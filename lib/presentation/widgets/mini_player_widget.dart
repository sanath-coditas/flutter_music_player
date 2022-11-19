import 'package:flutter/material.dart';
import 'package:music_player/presentation/widgets/audio_player_play_pause_button.dart';
import 'package:music_player/presentation/widgets/audio_player_slider.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_styles.dart';
import '../../data/models/app_song_model.dart';

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({
    Key? key,
    required this.songs,
    required this.index,
  }) : super(key: key);

  final List<AppSongModel> songs;
  final int index;

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 30,
                  right: 10,
                ),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.songs[widget.index].displayName,
                        style: TextStyles.poppinsW700S13CWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.songs[widget.index].artistName,
                        style: TextStyles.poppinsW400S10CWhite,
                      ),
                    ],
                  ),
                ),
              ),
              const AudioPlayerPlayPauseButton(playButtonSize: 30,),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  icon: const Icon(Icons.favorite_border_outlined),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Container(
          color: ColorConstants.darkBlueColor,
          child: const AudioPlayerSlider(),
        ),
      ],
    );
  }
}
