import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/widgets/audio_player_slider.dart';

import '../../constants/text_styles.dart';

class SongTimeTracker extends StatelessWidget {
  const SongTimeTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
      if (state is PlayingState) {
        return Padding(
          padding: const EdgeInsets.only(left: 25),
          child: StreamBuilder(
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
          ),
        );
      }
      if (state is PausedState) {
        return Padding(
          padding: const EdgeInsets.only(left: 25),
          child: StreamBuilder(
            stream: state.audioPlayerReturnType.positionChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.toString().substring(2, 7),
                  style: TextStyles.poppinsW300S12CWhite,
                );
              }
              return Text(
                Duration(seconds: AudioPlayerSlider.currentValue.toInt())
                    .toString()
                    .substring(2, 7),
                style: TextStyles.poppinsW300S12CWhite,
              );
            },
          ),
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
    });
  }
}
