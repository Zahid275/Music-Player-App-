import 'package:hive/hive.dart';
import 'package:music_player/Models/song.dart';

class DB_Services {

  static final box = Hive.box<Song>('favSongs');

  static add(Song song) {
    //If song is already in favSong then just return false
    if (box.values.contains(song)) {
      return false;
    }
    box.put(song.id, song);
    return true;
  }


  static deleteAt(index) {
    box.deleteAt(index);
  }

  static delete(int key) {
    box.delete(key);
  }

  static deleteAll() {
    box.clear();
  }

  static fetch() {
    List<Song> favSong = box.values.toList();
    return favSong;
  }
}
