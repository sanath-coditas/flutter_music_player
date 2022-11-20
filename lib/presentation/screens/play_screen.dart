import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/constants/text_styles.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/widgets/audio_player_play_pause_button.dart';
import 'package:music_player/presentation/widgets/audio_player_slider.dart';
import 'package:music_player/presentation/widgets/song_and_artist_title_widget.dart';
import 'package:music_player/presentation/widgets/song_time_tracker.dart';

import '../widgets/song_artist_fav_widget.dart';

// ignore: must_be_immutable
class PlayScreen extends StatelessWidget {
  PlayScreen(
      {super.key,
      required this.songs,
      required this.index,
      required this.isFav});
  final List<AppSongModel> songs;
  int index;
  bool isFav;
  double currentValue = AudioPlayerSlider.currentValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 22, 61, 1),
        elevation: 0,
        title: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            if (state is PlayingState) {
              return SongAndArtistTitleWidget(
                songName: state.audioPlayerReturnType.appSongModel.displayName,
                artistName: songs[index].artistName,
              );
            }
            if (state is PausedState) {
              return SongAndArtistTitleWidget(
                songName: state.audioPlayerReturnType.appSongModel.displayName,
                artistName: songs[index].artistName,
              );
            }

            return SongAndArtistTitleWidget(
              songName: songs[index].displayName,
              artistName: songs[index].artistName,
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(34, 22, 61, 1),
              Color.fromRGBO(42, 25, 49, 1),
              Color.fromRGBO(50, 26, 25, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.6,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(
                      'https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg'),
                ),
              ),
            ),
            BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
              builder: (context, state) {
                if (state is PlayingState) {
                  return SongArtistFavWidget(
                    appSongModel: state.audioPlayerReturnType.appSongModel,
                    artistName:
                        state.audioPlayerReturnType.appSongModel.artistName,
                    isFav: state.audioPlayerReturnType.appSongModel.isFavourite,
                    songName:
                        state.audioPlayerReturnType.appSongModel.displayName,
                  );
                }
                if (state is PausedState) {
                  return SongArtistFavWidget(
                    appSongModel: state.audioPlayerReturnType.appSongModel,
                    artistName:
                        state.audioPlayerReturnType.appSongModel.artistName,
                    isFav: state.audioPlayerReturnType.appSongModel.isFavourite,
                    songName:
                        state.audioPlayerReturnType.appSongModel.displayName,
                  );
                }
                return SongArtistFavWidget(
                  appSongModel: songs[index],
                  artistName: songs[index].artistName,
                  isFav: songs[index].isFavourite,
                  songName: songs[index].displayName,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SongTimeTracker(),
                const Expanded(child: AudioPlayerSlider()),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    builder: (context, state) {
                      if (state is PlayingState) {
                        return Text(
                          state.audioPlayerReturnType.appSongModel.duration
                              .toString()
                              .substring(2, 7),
                          style: TextStyles.poppinsW400S10CWhite,
                        );
                      }
                      if (state is PausedState) {
                        return Text(
                          state.audioPlayerReturnType.appSongModel.duration
                              .toString()
                              .substring(2, 7),
                          style: TextStyles.poppinsW400S10CWhite,
                        );
                      }
                      return Text(
                        songs[index].duration.toString().substring(2, 7),
                        style: TextStyles.poppinsW400S10CWhite,
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.repeat,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.fast_rewind,
                      color: Colors.white,
                      size: 30,
                    ),
                    // onPressed: () {},
                    onPressed: ((index - 1) >= 0)
                        ? () {
                            BlocProvider.of<AudioPlayerBloc>(context).add(
                                PlaySongEvent(appSongModel: songs[index - 1]));
                            index -= 1;
                          }
                        : null,
                  ),
                  const AudioPlayerPlayPauseButton(
                    playButtonSize: 60,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                      size: 30,
                    ),
                    // onPressed: () {},
                    onPressed: (index + 1 <= (songs.length - 1))
                        ? () {
                            BlocProvider.of<AudioPlayerBloc>(context).add(
                                PlaySongEvent(appSongModel: songs[index + 1]));
                            index += 1;
                          }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shuffle,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
