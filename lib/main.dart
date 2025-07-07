import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/controllers/home_controller.dart';
import 'package:music_player/controllers/play_screen_controller.dart';
import 'package:music_player/controllers/themeController.dart';
import 'package:music_player/Models/song.dart';
import 'package:music_player/services/db_services.dart';

import 'Views/home_screen.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SongAdapter());
  await Hive.openBox<Song>("favSongs");

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  Get.put(ThemeController());
  Get.put(PlayScreenController());
  Get.put(HomeController());



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      designSize: const Size(360, 690),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),

          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.theme,
        );
      },
    );
  }
}
