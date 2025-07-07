import 'dart:async';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/Models/song.dart';
import 'package:music_player/services/db_services.dart';
import 'home_controller.dart';

class PlayScreenController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();

  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;

  RxInt playingIndex = (-1).obs;
  RxBool isLoop = false.obs;
  Rx<Song> currentSong = Song(id: -1, title: "", artist: "", uri: "").obs;
  RxList<Song> favSongs = <Song>[].obs;







  //Updating current song when song is changed
  Future<void> updateSong(Song song) async {
    currentSong.value = song;
  }


  //It plays the next song
  void playNext(bool isHome) {
    final homeController = Get.find<HomeController>();
    List<Song> songs = homeController.songs;

    if (playingIndex.value + 1 < songs.length) {
      playingIndex.value = playingIndex.value + 1;
      currentSong.value =
          isHome ? songs[playingIndex.value] : favSongs[playingIndex.value];
      update();

      audioPlayer.seekToNext().then((_) {
        audioPlayer.play();
      });
    }
  }

  //It plays the precious song
  void playPrevious(bool isHome) {
    final homeController = Get.find<HomeController>();

    List<Song> songs = homeController.songs;

    if (playingIndex.value - 1 >= 0) {
      playingIndex.value = playingIndex.value - 1;
      currentSong.value =
      isHome ? songs[playingIndex.value] : favSongs[playingIndex.value];

      update();
      audioPlayer.seekToPrevious().then((_) {
        audioPlayer.play();
      });
    }
  }


  //It changes the Loop Mode whether to play next song after finishing or to play the same one
  Future<void> toggleLoopMode() async {
    try{
      isLoop.value = !isLoop.value;
      await audioPlayer.setLoopMode(isLoop.value ? LoopMode.one : LoopMode.off);
      print("Loop mode: ${isLoop.value}");
    }catch(e){
      print("Could not update loop mode");
    }

  }



  //It build our plays list means which list of songs has to be played
  Future<void> buildPlaylist(bool isHome) async {
    final homeController = Get.find<HomeController>();

    List<Song> songs;

    isHome ? songs = homeController.songs : songs = favSongs;

    try {
      if (homeController.songs.isEmpty) return;

      await audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children:
              songs.map((music) {
                return AudioSource.uri(
                  Uri.parse(music.uri),
                  tag: MediaItem(
                    isLive: true,
                    id: music.id.toString(),
                    title: music.title ?? 'Unknown Title',
                  ),
                );
              }).toList(),
        ),
      );
    } catch (e) {
      print('Error building playlist: $e');
    }
  }


  //It initializes the player by first calling build playlist and
  // then listen for changes like playstream,position,duration,songindex
  Future<void> initPlayer(int index, bool isHome) async {
    try {
      if (playingIndex.value == index) {
        return;
      }

      await buildPlaylist(isHome);
      audioPlayer.currentIndexStream.listen((index) {
        if (index != null) {
          playingIndex.value = index;
          final homeController = Get.find<HomeController>();
          currentSong!.value =
              isHome ? homeController.songs[index] : favSongs[index];
          update();
        }
      });

      _playerStateSubscription = audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed &&
            isLoop.value == false) {
          playNext(isHome);
        }
      });

      _positionSubscription = audioPlayer.positionStream.listen((value) {
        position.value = value;
      });

      _durationSubscription = audioPlayer.durationStream.listen((dur) {
        if (dur != null) duration.value = dur;
      });
    } catch (e) {
      print('Error initializing player: $e');
    }
  }


  //This function actually plays our song
  Future<void> playSong(int index, {required isHome}) async {

    await initPlayer(index, isHome);
    final homeController = Get.find<HomeController>();

    //if already playing song is played just return the function
    if (playingIndex.value == index) {
      return;
    }
    // New song selected
    playingIndex.value = index;

    currentSong.value = isHome ? homeController.songs[index] : favSongs[index];
    await audioPlayer.seek(Duration.zero, index: index);
    await audioPlayer.play();
  }

  //It is called when either fav button is pressed
  triggerFav(Song song) async {
    if (!(favSongs.contains(song))) {
      try {
        bool alpha = DB_Services.add(song);
        if (alpha) {
          favSongs.add(song);
          print("Successfully added to favourites");
        }
      } catch (e) {
        print("Could not add to favourite because of this error $e");
      }
    } else {
      try {
        DB_Services.delete(song.id);
        favSongs.remove(song);
      } catch (e) {
        print("Could not remove from favourite because of this error $e");
      }
    }
  }


  //called when song is paused and played
  Future<void> playPause() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }
}
