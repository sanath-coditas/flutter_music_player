import 'package:audioplayers/audioplayers.dart';
import 'package:kiwi/kiwi.dart';
import 'package:music_player/data/datasources/local_data_source.dart';
import 'package:music_player/data/repositories/songs_repositpry_impl.dart';
import 'package:music_player/domain/repositories/songs_repository.dart';
import 'package:music_player/domain/usecases/fetch_songs_usecase.dart';
import 'package:music_player/domain/usecases/audio_player_usecase.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/blocs/home_screen_bloc/homescreen_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'dependency_injection.g.dart';

abstract class Injector {
  static KiwiContainer? container;
  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container!.resolve();

  //! Blocs
  @Register.factory(HomescreenBloc)
  @Register.factory(AudioPlayerBloc)

  //! Usecases
  @Register.factory(FetchSongsUsecase)
  @Register.factory(AudioPlayerUsecase)

  //! Repositories
  @Register.factory(SongsRepository, from: SongsRepositoryImpl)

  //! DataSources
  @Register.factory(LocalDataSource, from: PhoneStorageMusicDataSource)
  @Register.factory(PhoneStorageMusicDataSource)
  @Register.factory(OnAudioQuery)
  @Register.factory(AudioPlayer)
  // ignore: unused_element
  void _configure();
}
