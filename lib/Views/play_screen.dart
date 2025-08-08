import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/controllers/play_screen_controller.dart';
import 'package:music_player/controllers/themeController.dart';
import 'package:music_player/widgets/actionBtn.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Models/song.dart';

class PlayScreen extends StatefulWidget {
  final Song songDetails;
  final selectedIndex;
  final bool isHome;

  PlayScreen({
    required this.songDetails,
    required this.selectedIndex,
    required this.isHome,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final controller = Get.find<PlayScreenController>();
  final themeController = Get.find<ThemeController>();

  void init() async {
    await controller.updateSong(widget.songDetails);
    controller.playSong(widget.selectedIndex, isHome: widget.isHome);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLight = themeController.isLight.value;

      return Scaffold(
appBar: AppBar(        backgroundColor: AppColors.backgroundColor(isLight),
),
        backgroundColor: AppColors.backgroundColor(isLight),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 7.sp),

                margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 30.sp),
                width: 250.sp,
                height: 250.sp,

                decoration: BoxDecoration(
                  color: AppColors.darkShadow(isLight),

                  borderRadius: BorderRadius.circular(250),
                  boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 2)],
                ),
                child: QueryArtworkWidget(
                  keepOldArtwork: false,
                  quality: 100,
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: BorderRadius.circular(250),
                  id: controller.currentSong.value.id,

                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Icon(Icons.music_note),
                ),
              ),

              Obx(() {
                double p = controller.position.value.inSeconds.toDouble();
                double d = controller.duration.value.inSeconds.toDouble();

                //minutes and seconds for duration of song
                final m1 = d ~/ 60;
                final s1 = d % 60;

                //minutes and secondes for current song play position
                final m2 = p ~/ 60;
                final s2 = p % 60;
                // Set<dynamic> favSongId = controller.favSongsId;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.sp),

                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.symmetric(horizontal: 30.sp),
                      child: Column(
                        children: [
                          Text(
                            controller.currentSong.value.title,
                            style: GoogleFonts.poppins(fontSize: 18.sp),
                          ),
                          Text(
                            "${controller.currentSong.value.artist}",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.triggerFav(controller.currentSong.value);
                            },
                            icon:
                                controller.favSongs.contains(
                                      controller.currentSong.value,
                                    )
                                    ? Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.red,
                                      size: 30.sp,
                                    )
                                    : Icon(FontAwesomeIcons.heart, size: 30.sp),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.sp),

                    Slider(
                      activeColor: AppColors.darkShadow(!isLight),
                      thumbColor: AppColors.btnColor2(isLight),
                      secondaryActiveColor: Colors.green,
                      min: 0,
                      max: d,
                      value: p.clamp(0, d),
                      onChanged: (value) {
                        controller.audioPlayer.seek(
                          Duration(seconds: value.toInt()),
                        );
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$m2:${s2.toStringAsFixed(0)}"),
                          Text("$m1:${s1.toStringAsFixed(0)}"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Actionbtn(
                          btnColor: AppColors.btnColor(isLight),

                          icon: Icon(
                            Icons.skip_previous,
                            size: 30.sp,
                            color: Colors.blueGrey.shade400,
                          ),
                          onTap: () {
                            controller.playPrevious(widget.isHome);
                          },
                        ),
                        SizedBox(width: 20.sp),

                        Actionbtn(
                          btnColor: AppColors.btnColor2(isLight),

                          onTap: () {
                            controller.playPause();
                          },
                          icon:
                              controller.audioPlayer.playing
                                  ? Icon(
                                    Icons.pause,
                                    size: 30.sp,
                                    color: AppColors.lightShadow(isLight),
                                  )
                                  : Icon(
                                    Icons.play_arrow,
                                    size: 30.sp,
                                    color: AppColors.lightShadow(isLight),
                                  ),
                        ),
                        SizedBox(width: 20.sp),

                        Actionbtn(
                          icon: Icon(
                            Icons.skip_next,
                            size: 30.sp,
                            color: Colors.blueGrey.shade400,
                          ),
                          onTap: () {
                            controller.playNext(widget.isHome);
                          },
                          btnColor: AppColors.btnColor(isLight),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.sp,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              controller.isLoop.value
                                  ? AppColors.btnColor2(isLight)
                                  : AppColors.darkShadow(isLight),
                          radius: 20.sp,
                          child: IconButton(
                            onPressed: () {
                             controller.toggleLoopMode();
                            },
                            icon: Icon(
                              Icons.loop,
                              size: 20.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.sp),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
