import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/data/models/app_song_model.dart';

import '../../constants/text_styles.dart';
import '../blocs/audio_player_bloc/audio_player_bloc.dart';

class SongArtistFavWidget extends StatelessWidget {
  const SongArtistFavWidget({
    required this.appSongModel,
    required this.artistName,
    required this.isFav,
    required this.songName,
    Key? key,
  }) : super(key: key);
  final String songName;
  final String artistName;
  final AppSongModel appSongModel;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  songName,
                  style: TextStyles.poppinsW700S20CWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  artistName,
                  style: TextStyles.poppinsW400S14CWhite,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: IconButton(
            color: isFav ? Colors.red : Colors.white,
            iconSize: 30,
            icon: isFav
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
            onPressed: () {
              BlocProvider.of<AudioPlayerBloc>(context).add(ToggleFavoriteEvent(
                appSongModel: appSongModel,
              ));
            },
          ),
        ),
      ],
    );
  }
}
