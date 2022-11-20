// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';
import 'package:music_player/domain/usecases/audio_player_usecase.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_player/core/errors/failure.dart';
import 'package:music_player/data/models/app_song_model.dart';

abstract class LocalDataSource {
  Future<Either<Failure, List<AppSongModel>>> fetchSongs();
  Future<Either<Failure, AudioPlayerReturnType>> playSong(
      {required AppSongModel songModel});
  Future<Either<Failure, AudioPlayerReturnType>> pauseSong(
      {required AppSongModel songModel});
  Future<Either<Failure, AudioPlayerReturnType>> seekSong(
      {required AppSongModel songModel, required Duration seekDuration});
  Future<Either<Failure, AudioPlayerReturnType>> stopSong(
      {required AppSongModel songModel});
  Future<Either<Failure, AppSongModel>> toggleFavorite(
      {required AppSongModel songModel});
}

class PhoneStorageMusicDataSource implements LocalDataSource {
  final OnAudioQuery audioQuery;
  final AudioPlayer audioPlayer;
  PhoneStorageMusicDataSource({
    required this.audioQuery,
    required this.audioPlayer,
  });

  @override
  Future<Either<Failure, List<AppSongModel>>> fetchSongs() async {
    final status = await Permission.storage.request();
    List<AppSongModel> songsList = [];
    if (status.isGranted) {
      try {
        List<SongModel> songs = await audioQuery.querySongs();
        for (SongModel song in songs) {
          songsList.add(AppSongModel.fromJson(song.getMap));
        }
        return Right(songsList);
      } on Exception catch (e) {
        return Left(FetchFailure(message: e.toString()));
      }
    } else {
      return Left(
          FetchFailure(message: 'Permission is required to fetch Songs'));
    }
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> playSong(
      {required AppSongModel songModel}) async {
    try {
      songModel.isPlaying = true;
      await audioPlayer.play(DeviceFileSource(songModel.path));
      return Right(AudioPlayerReturnType(
        appSongModel: songModel,
        durationChanged: audioPlayer.onDurationChanged,
        playerComplete: audioPlayer.onPlayerComplete,
        playerStateChanged: audioPlayer.onPlayerStateChanged,
        positionChanged: audioPlayer.onPositionChanged,
      ));
    } on Exception catch (e) {
      return Left(PlayFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> pauseSong(
      {required AppSongModel songModel}) async {
    try {
      songModel.isPlaying = false;
      await audioPlayer.pause();
      return Right(AudioPlayerReturnType(
        appSongModel: songModel,
        durationChanged: audioPlayer.onDurationChanged,
        playerComplete: audioPlayer.onPlayerComplete,
        playerStateChanged: audioPlayer.onPlayerStateChanged,
        positionChanged: audioPlayer.onPositionChanged,
      ));
    } on Exception catch (e) {
      return Left(PauseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> seekSong(
      {required AppSongModel songModel, required Duration seekDuration}) async {
    try {
      await audioPlayer.seek(seekDuration);
      return Right(AudioPlayerReturnType(
        appSongModel: songModel,
        durationChanged: audioPlayer.onDurationChanged,
        playerComplete: audioPlayer.onPlayerComplete,
        playerStateChanged: audioPlayer.onPlayerStateChanged,
        positionChanged: audioPlayer.onPositionChanged,
      ));
    } on Exception catch (e) {
      return Left(PauseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AudioPlayerReturnType>> stopSong(
      {required AppSongModel songModel}) async {
    try {
      songModel.isPlaying = false;
      await audioPlayer.stop();
      return Right(AudioPlayerReturnType(
        appSongModel: songModel,
        durationChanged: audioPlayer.onDurationChanged,
        playerComplete: audioPlayer.onPlayerComplete,
        playerStateChanged: audioPlayer.onPlayerStateChanged,
        positionChanged: audioPlayer.onPositionChanged,
      ));
    } on Exception catch (e) {
      return Left(PauseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppSongModel>> toggleFavorite(
      {required AppSongModel songModel}) async {
    try {
      songModel.isFavourite = !songModel.isFavourite;
      return Right(songModel);
    } on Exception catch (_) {
      return Left(
        FetchFailure(message: 'Unable to toggle....'),
      );
    }
  }
}
