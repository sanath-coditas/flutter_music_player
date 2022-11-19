import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';

import '../../constants/color_constants.dart';

class AudioPlayerSlider extends StatefulWidget {
  static double currentValue = 0;
  const AudioPlayerSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioPlayerSlider> createState() => _AudioPlayerSliderState();
}

class _AudioPlayerSliderState extends State<AudioPlayerSlider> {
  double minValue = 0;

  double maxValue = 0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
          trackHeight: 3,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.2)),
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          if (state is PlayingState) {
            maxValue = state
                .audioPlayerReturnType.appSongModel.duration.inSeconds
                .toDouble();
            return StreamBuilder<Duration>(
                stream: state.audioPlayerReturnType.positionChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AudioPlayerSlider.currentValue =
                        snapshot.data!.inSeconds.toDouble();
                    return Slider(
                      value: AudioPlayerSlider.currentValue,
                      min: minValue,
                      max: maxValue,
                      activeColor: Colors.white,
                      inactiveColor: ColorConstants.lightGreyColor,
                      onChanged: (val) {
                        setState(() {});
                        BlocProvider.of<AudioPlayerBloc>(context)
                            .add(SeekSongEvent(
                          appSongModel:
                              state.audioPlayerReturnType.appSongModel,
                          duration: Duration(seconds: val.toInt()),
                        ));
                      },
                    );
                  }
                  if (snapshot.hasError) {}
                  return Container();
                });
          }
          if (state is PausedState) {
            maxValue = state
                .audioPlayerReturnType.appSongModel.duration.inSeconds
                .toDouble();
            return StreamBuilder<Duration>(
                stream: state.audioPlayerReturnType.positionChanged,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data != null) {
                    AudioPlayerSlider.currentValue =
                        snapshot.data!.inSeconds.toDouble();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    log('here.........');
                    return Slider(
                      value: AudioPlayerSlider.currentValue,
                      min: minValue,
                      max: maxValue,
                      activeColor: Colors.white,
                      inactiveColor: ColorConstants.lightGreyColor,
                      onChanged: (val) {
                        setState(() {});
                        BlocProvider.of<AudioPlayerBloc>(context)
                            .add(SeekSongEvent(
                          appSongModel:
                              state.audioPlayerReturnType.appSongModel,
                          duration: Duration(seconds: val.toInt()),
                        ));
                      },
                    );
                  }
                  if (snapshot.hasData) {
                    AudioPlayerSlider.currentValue =
                        snapshot.data!.inSeconds.toDouble();
                    return Slider(
                      value: AudioPlayerSlider.currentValue,
                      min: minValue,
                      max: maxValue,
                      activeColor: Colors.white,
                      inactiveColor: ColorConstants.lightGreyColor,
                      onChanged: (val) {
                        setState(() {});
                        BlocProvider.of<AudioPlayerBloc>(context)
                            .add(SeekSongEvent(
                          appSongModel:
                              state.audioPlayerReturnType.appSongModel,
                          duration: Duration(seconds: val.toInt()),
                        ));
                      },
                    );
                  }
                  if (snapshot.hasError) {}
                  return Container();
                });
          } else {
            return Slider(
              value: 0,
              min: 0,
              activeColor: Colors.white,
              inactiveColor: ColorConstants.lightGreyColor,
              onChanged: (val) {
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }
}
