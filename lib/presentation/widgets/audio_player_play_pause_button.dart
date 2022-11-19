import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';

class AudioPlayerPlayPauseButton extends StatelessWidget {
  const AudioPlayerPlayPauseButton({
    required this.playButtonSize,
    Key? key,
  }) : super(key: key);
  final double playButtonSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is PlayingState) {
          return StreamBuilder<PlayerState>(
              stream: state.audioPlayerReturnType.playerStateChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  BlocProvider.of<AudioPlayerBloc>(context).add(
                      StopSongEvent(
                          appSongModel: state
                              .audioPlayerReturnType.appSongModel));
                }
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return IconButton(
                    iconSize: playButtonSize,
                    color: Colors.white,
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      BlocProvider.of<AudioPlayerBloc>(context).add(
                          PauseSongEvent(
                              appSongModel: state
                                  .audioPlayerReturnType
                                  .appSongModel));
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        }
        if (state is PausedState) {
          return IconButton(
            color: Colors.white,
            iconSize: playButtonSize,
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              BlocProvider.of<AudioPlayerBloc>(context).add(
                  PlaySongEvent(
                      appSongModel:
                          state.audioPlayerReturnType.appSongModel));
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
