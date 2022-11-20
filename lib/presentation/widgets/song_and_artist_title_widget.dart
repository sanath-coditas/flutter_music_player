import 'package:flutter/material.dart';
import '../../constants/text_styles.dart';

class SongAndArtistTitleWidget extends StatelessWidget {
  const SongAndArtistTitleWidget({
    Key? key,
    required this.songName,
    required this.artistName,
  }) : super(key: key);
  final String songName;
  final String artistName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          songName,
          style: TextStyles.poppinsW700S24CWhite,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          artistName,
          style: TextStyles.poppinsW400S18CWhite,
        ),
      ],
    );
  }
}
