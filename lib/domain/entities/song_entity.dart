class SongEntity {
  final String displayName;
  final String artistName;
  final String path;
  final Duration duration;
  bool isPlaying = false;
  bool isFavourite = false;
  SongEntity({
    required this.displayName,
    required this.artistName,
    required this.path,
    required this.duration,
    required this.isPlaying,
    required this.isFavourite,
  });
}
