import 'package:music_player/domain/entities/song_entity.dart';

class AppSongModel extends SongEntity {
  AppSongModel({
    required super.displayName,
    required super.artistName,
    required super.path,
    required super.duration,
    required super.isPlaying,
    required super.isFavourite,
  });

  factory AppSongModel.fromJson(Map<dynamic, dynamic> json) {
    return AppSongModel(
      artistName: json['artist'],
      displayName: json['_display_name'],
      duration: Duration(milliseconds: json['duration']),
      path: json['_data'],
      isPlaying: false,
      isFavourite: false,
    );
  }
}
