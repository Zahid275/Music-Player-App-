import 'package:get/get.dart';
import 'package:music_player/controllers/play_screen_controller.dart';
import 'package:music_player/services/db_services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Models/song.dart';

class HomeController extends GetxController {
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  Rx<bool>? isStorageDenied = true.obs;
  Rx<bool>? isAudioDenied = true.obs;

  final playController = Get.find<PlayScreenController>();
  var songs = <Song>[].obs;

  //request for required permissions for fetching and playing songs
  Future<void> requestPermission() async {
    isStorageDenied!.value = await Permission.storage.isDenied;
    isStorageDenied!.value = await Permission.storage.isDenied;

    if (isStorageDenied!.value) {
      await Permission.storage.request();
    }
    if (isAudioDenied!.value) {
      await Permission.audio.request();
    }
  }

  //Fetch song Function
  getSongs() async {
    List<SongModel> result = await onAudioQuery.querySongs();
    for (int i = 0; i < result.length; i++) {
      Song obj = Song(
        id: result[i].id,
        title: result[i].title,
        artist: result[i].artist.toString(),
        uri: result[i].uri.toString(),
      );
      songs.add(obj);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetching fav songs from local db
    playController.favSongs.value = DB_Services.fetch();
    requestPermission().then((_) => getSongs());
  }
}
