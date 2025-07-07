import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/Models/song.dart';
import 'package:music_player/Views/play_screen.dart';
import 'package:music_player/controllers/play_screen_controller.dart';
import '../constants/colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/song_tile.dart';

Widget favTab(favSongs,bool isLight) {

  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: favSongs.length,
          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 12,
              ),
              child: SongTile(
                key: ValueKey(favSongs[index].id),
                onDelete: (){
                  final controller = Get.find<PlayScreenController>();
                  controller.triggerFav(favSongs[index]);
                },
                tileColor: AppColors.tileColor(isLight),
                song: favSongs[index],
                height: 80.sp,
                ontap: () {
                  Get.to(() {
                    return PlayScreen(
                      isHome: false,
                      songDetails: favSongs[index],
                      selectedIndex: index,
                    );
                  });
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}


Widget homeTab(HomeController controller, bool isLight) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: controller.songs.length,
          itemBuilder: (context, index) {
            Song song = controller.songs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 12,
              ),
              child: SongTile(
                tileColor: AppColors.tileColor(isLight),
                song: song,
                height: 80.sp,
                ontap: () {
                  Get.to(() {
                    return PlayScreen(
                        isHome: true,
                        songDetails: song, selectedIndex: index);
                  });
                },
              ),
            );
          },
        ),
      ),
    ],
  );
}
