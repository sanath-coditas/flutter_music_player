import 'package:dartz/dartz.dart';
import 'package:music_player/core/errors/failure.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/domain/repositories/songs_repository.dart';

class FetchSongsUsecase {
  final SongsRepository songsRepository;
  FetchSongsUsecase({
    required this.songsRepository,
  });

  Future<Either<Failure, List<AppSongModel>>> fetchSongs() async {
    return await songsRepository.fetchSongs();
  }
}
