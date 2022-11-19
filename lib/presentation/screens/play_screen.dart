import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/constants/text_styles.dart';
import 'package:music_player/data/models/app_song_model.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/widgets/audio_player_play_pause_button.dart';
import 'package:music_player/presentation/widgets/audio_player_slider.dart';

// ignore: must_be_immutable
class PlayScreen extends StatelessWidget {
  PlayScreen({super.key, required this.songs, required this.index});
  final List<AppSongModel> songs;
  final int index;

  double currentValue = AudioPlayerSlider.currentValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 22, 61, 1),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              songs[index].displayName,
              style: TextStyles.poppinsW700S24CWhite,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              songs[index].artistName,
              style: TextStyles.poppinsW400S18CWhite,
            ),
          ],
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: Text(
            //     songs[index].displayName,
            //     style: TextStyles.poppinsW700S24CWhite,
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            // Text(
            //   songs[index].artistName,
            //   style: TextStyles.poppinsW400S18CWhite,
            // ),
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
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  songs[index].displayName,
                  style: TextStyles.poppinsW700S20CWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  songs[index].artistName,
                  style: TextStyles.poppinsW400S14CWhite,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        builder: (context, state) {
                      if (state is PlayingState) {
                        return StreamBuilder(
                          stream: state.audioPlayerReturnType.positionChanged,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.toString().substring(2, 7),
                                style: TextStyles.poppinsW300S12CWhite,
                              );
                            }
                            return Text(
                              '--:--',
                              style: TextStyles.poppinsW300S12CWhite,
                            );
                          },
                        );
                      }
                      if (state is PausedState) {
                        return StreamBuilder(
                          stream: state.audioPlayerReturnType.positionChanged,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.toString().substring(2, 7),
                                style: TextStyles.poppinsW300S12CWhite,
                              );
                            }
                            return Text(
                              Duration(
                                      seconds: AudioPlayerSlider.currentValue
                                          .toInt())
                                  .toString()
                                  .substring(2, 7),
                              style: TextStyles.poppinsW300S12CWhite,
                            );
                          },
                        );
                      }
                      if (state is FailureState) {
                        return Text(
                          '--:--',
                          style: TextStyles.poppinsW300S12CWhite,
                        );
                      } else {
                        return Text(
                          '--:--',
                          style: TextStyles.poppinsW300S12CWhite,
                        );
                      }
                    })),
                const Expanded(child: AudioPlayerSlider()),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    songs[index].duration.toString().substring(2, 7),
                    style: TextStyles.poppinsW400S10CWhite,
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
                    onPressed: () {},
                    // onPressed: ((index - 1) >= 0) ? () {
                    //   BlocProvider.of<AudioPlayerBloc>(context).add(
                    //               PlaySongEvent(
                    //                   appSongModel: songs[index - 1]));
                    // } : null,
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
                    onPressed: () {},
                    // onPressed: (index + 1 <= (songs.length - 1))
                    //     ? () {
                    //         BlocProvider.of<AudioPlayerBloc>(context).add(
                    //             PlaySongEvent(appSongModel: songs[index + 1]));
                    //       }
                    //     : null,
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
