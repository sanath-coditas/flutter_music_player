part of 'homescreen_bloc.dart';
abstract class HomescreenState {}

class HomescreenInitial extends HomescreenState {}

class LoadingState extends HomescreenState {}

class LoadedState extends HomescreenState {
  final List<AppSongModel> songs;
  LoadedState({
    required this.songs,
  });
}

class FailureState extends HomescreenState {
  final String message;
  FailureState({
    required this.message,
  });
  
}
