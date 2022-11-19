import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/domain/usecases/audio_player_usecase.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayerUsecase audioPlayerUsecase;
  AudioPlayerBloc({
    required this.audioPlayerUsecase,
  }) : super(AudioPlayerInitial()) {
    on<AudioPlayerEvent>((event, emit) {});
    on<PlaySongEvent>((event, emit) async {
      final playStatus =
          await audioPlayerUsecase.playSong(songModel: event.appSongModel);
      playStatus.fold((l) => emit(FailureState(message: l.message)),
          (r) => emit(PlayingState(audioPlayerReturnType: r)));
    });
    on<PauseSongEvent>((event, emit) async {
      final pauseStatus =
          await audioPlayerUsecase.pauseSong(songModel: event.appSongModel);
      pauseStatus.fold((l) => FailureState(message: l.message),
          (r) => emit(PausedState(audioPlayerReturnType: r)));
    });
    on<SeekSongEvent>((event, emit) async {
      final seekStatus = await audioPlayerUsecase.seekSong(
          appSongModel: event.appSongModel, seekDuration: event.duration);
      seekStatus.fold((l) => emit(FailureState(message: l.message)), (r) {
        if (state is PlayingState) {
          emit(PlayingState(audioPlayerReturnType: r));
        } else if (state is PausedState) {
          emit(PausedState(audioPlayerReturnType: r));
        }
      });
    });

    on<StopSongEvent>((event, emit) async {
      final pauseStatus =
          await audioPlayerUsecase.stopSong(songModel: event.appSongModel);
      pauseStatus.fold((l) => FailureState(message: l.message),
          (r) => emit(PausedState(audioPlayerReturnType: r)));
    });
  }
}
