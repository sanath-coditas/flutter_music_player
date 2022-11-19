import 'package:dartz/dartz.dart';
import 'package:music_player/core/errors/failure.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/domain/usecases/audio_player_usecase.dart';

abstract class SongsRepository {
  Future<Either<Failure, List<AppSongModel>>> fetchSongs();
  Future<Either<Failure, AudioPlayerReturnType>> playSong(
      {required AppSongModel songModel});
  Future<Either<Failure, AudioPlayerReturnType>> pauseSong(
      {required AppSongModel songModel});
  Future<Either<Failure, AudioPlayerReturnType>> seekSong(
      {required AppSongModel songModel, required Duration seekDuration});
  Future<Either<Failure, AudioPlayerReturnType>> stopSong(
      {required AppSongModel songModel});    
}
