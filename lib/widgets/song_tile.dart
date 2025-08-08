import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/constants/textstyles.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Models/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final double height;
  final void Function()? ontap;
  final Color tileColor;
  final void Function()? onDelete;

  SongTile({
    super.key,
    required this.song,
    required this.height,
    required this.ontap,
    required this.tileColor,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: tileColor,
          boxShadow: [BoxShadow(spreadRadius: 0.2, blurRadius: 6)],
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: QueryArtworkWidget(
                  quality: 100,
                  artworkQuality: FilterQuality.high,
                  artworkWidth: 90.sp,
                  artworkHeight: 90.sp,
                  artworkBorder: BorderRadius.circular(12),
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: Icon(Icons.music_note),
                  id: song.id,
                  type: ArtworkType.AUDIO,
                ),
              ),

              SizedBox(width: 20.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(song.title, overflow: TextOverflow.ellipsis,style: tileTextStyle(),),
                    Text("${song.artist}"),
                  ],
                ),
              ),
              onDelete != null
                  ? IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red.shade700),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
