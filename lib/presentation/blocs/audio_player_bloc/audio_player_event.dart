// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class PlaySongEvent extends AudioPlayerEvent {
  final AppSongModel appSongModel;
  const PlaySongEvent({
    required this.appSongModel,
  });
}

class PauseSongEvent extends AudioPlayerEvent {
  final AppSongModel appSongModel;
  const PauseSongEvent({
    required this.appSongModel,
  });
}

class SeekSongEvent extends AudioPlayerEvent {
  final AppSongModel appSongModel;
  final Duration duration;
  const SeekSongEvent({
    required this.appSongModel,
    required this.duration,
  });
  
}


class StopSongEvent extends AudioPlayerEvent {
  final AppSongModel appSongModel;
  const StopSongEvent({
    required this.appSongModel,
  });
}
