import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song extends HiveObject {
  Song({required this.id, required this.title, required this.artist,required this.uri});

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String artist;

  @HiveField(3)
  String uri;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Song && id == other.id);

  @override
  int get hashCode => id.hashCode;

}
