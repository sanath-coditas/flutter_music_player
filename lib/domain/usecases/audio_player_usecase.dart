// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';

import 'package:music_player/core/errors/failure.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/domain/repositories/songs_repository.dart';

class AudioPlayerUsecase {
  final SongsRepository songsRepository;
  AudioPlayerUsecase({
    required this.songsRepository,
  });
  Future<Either<Failure, AudioPlayerReturnType>> playSong(
      {required AppSongModel songModel}) async {
    return await songsRepository.playSong(songModel: songModel);
  }

  Future<Either<Failure, AudioPlayerReturnType>> pauseSong(
      {required AppSongModel songModel}) async {
    return await songsRepository.pauseSong(songModel: songModel);
  }

  Future<Either<Failure, AudioPlayerReturnType>> seekSong(
      {required AppSongModel appSongModel,required Duration seekDuration}) async {
    return await songsRepository.seekSong(songModel: appSongModel,seekDuration: seekDuration);
  }
  Future<Either<Failure, AudioPlayerReturnType>> stopSong(
      {required AppSongModel songModel}) async {
    return await songsRepository.stopSong(songModel: songModel);
  }
  Future<Either<Failure, AppSongModel>> toggleFavorite(
      {required AppSongModel songModel}) async {
    return await songsRepository.toggleFavorite(songModel: songModel);
  } 
}

class AudioPlayerReturnType {
  final AppSongModel appSongModel;
  final Stream<PlayerState> playerStateChanged;
  final Stream<Duration> positionChanged;
  final Stream<Duration> durationChanged;
  final Stream<void> playerComplete;
  AudioPlayerReturnType({
    required this.appSongModel,
    required this.playerStateChanged,
    required this.positionChanged,
    required this.durationChanged,
    required this.playerComplete,
  });
}
