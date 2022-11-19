// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_injection.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => HomescreenBloc(fetchSongsUsecase: c<FetchSongsUsecase>()))
      ..registerFactory(
          (c) => AudioPlayerBloc(audioPlayerUsecase: c<AudioPlayerUsecase>()))
      ..registerFactory(
          (c) => FetchSongsUsecase(songsRepository: c<SongsRepository>()))
      ..registerFactory(
          (c) => AudioPlayerUsecase(songsRepository: c<SongsRepository>()))
      ..registerFactory<SongsRepository>(
          (c) => SongsRepositoryImpl(localDataSource: c<LocalDataSource>()))
      ..registerFactory<LocalDataSource>((c) => PhoneStorageMusicDataSource(
          audioQuery: c<OnAudioQuery>(), audioPlayer: c<AudioPlayer>()))
      ..registerFactory((c) => PhoneStorageMusicDataSource(
          audioQuery: c<OnAudioQuery>(), audioPlayer: c<AudioPlayer>()))
      ..registerFactory((c) => OnAudioQuery())
      ..registerFactory((c) => AudioPlayer());
  }
}
