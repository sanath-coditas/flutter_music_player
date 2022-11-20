import 'package:dartz/dartz.dart';
import 'package:music_player/core/errors/failure.dart';
import 'package:music_player/data/datasources/local_data_source.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/domain/repositories/songs_repository.dart';
import 'package:music_player/domain/usecases/audio_player_usecase.dart';

class SongsRepositoryImpl implements SongsRepository {
  final LocalDataSource localDataSource;
  SongsRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<AppSongModel>>> fetchSongs() async {
    return await localDataSource.fetchSongs();
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> playSong(
      {required AppSongModel songModel}) async {
    return await localDataSource.playSong(songModel: songModel);
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> pauseSong(
      {required AppSongModel songModel}) async {
    return await localDataSource.pauseSong(songModel: songModel);
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> seekSong(
      {required AppSongModel songModel, required Duration seekDuration}) async {
    return await localDataSource.seekSong(
        songModel: songModel, seekDuration: seekDuration);
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> stopSong(
      {required AppSongModel songModel}) async {
    return await localDataSource.stopSong(songModel: songModel);
  }

  @override
  Future<Either<Failure, AppSongModel>> toggleFavorite(
      {required AppSongModel songModel}) async {
    return await localDataSource.toggleFavorite(songModel: songModel);
  }
}
