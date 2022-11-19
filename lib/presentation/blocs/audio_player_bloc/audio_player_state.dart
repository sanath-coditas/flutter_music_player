// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audio_player_bloc.dart';

abstract class AudioPlayerState {
  const AudioPlayerState();
}

class AudioPlayerInitial extends AudioPlayerState {}

class PlayingState extends AudioPlayerState {
  final AudioPlayerReturnType audioPlayerReturnType;
  const PlayingState({
    required this.audioPlayerReturnType,
  });
}

class FailureState extends AudioPlayerState {
  final String message;
  const FailureState({
    required this.message,
  });
}

class PausedState extends AudioPlayerState {
  final AudioPlayerReturnType audioPlayerReturnType;
  const PausedState({required this.audioPlayerReturnType});
}
