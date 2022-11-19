import 'package:bloc/bloc.dart';
import 'package:music_player/domain/usecases/fetch_songs_usecase.dart';
import '../../../data/models/app_song_model.dart';
part 'homescreen_event.dart';
part 'homescreen_state.dart';

class HomescreenBloc extends Bloc<HomescreenEvent, HomescreenState> {
  final FetchSongsUsecase fetchSongsUsecase;
  HomescreenBloc({
    required this.fetchSongsUsecase,
  }) : super(HomescreenInitial()) {
    on<HomescreenEvent>((event, emit) {});

    on<FetchMusicEvent>((event, emit) async {
      final statusOfFetchSongs = await fetchSongsUsecase.fetchSongs();
      statusOfFetchSongs.fold((l) => emit(FailureState(message: l.message)),
          (r) => emit(LoadedState(songs: r)));
    });
  }
}
