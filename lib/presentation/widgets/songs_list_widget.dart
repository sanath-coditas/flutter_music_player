import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/widgets/mini_player_widget.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_styles.dart';
import 'package:music_player/presentation/blocs/home_screen_bloc/homescreen_bloc.dart';
import '../screens/play_screen.dart';

class SongsListWidget extends StatelessWidget {
  const SongsListWidget({Key? key, required this.state}) : super(key: key);
  final LoadedState state;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, top: 5),
      itemBuilder: (context, index) {
        return ListTileTheme(
          selectedTileColor: ColorConstants.darkVioletColor,
          child: ListTile(
            selected: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  'https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg'),
            ),
            title: Text(
              state.songs[index].displayName,
              style: TextStyles.poppinsW400S14CWhite,
            ),
            subtitle: Text(
              state.songs[index].artistName,
              style: TextStyles.poppinsW300S12CWhite,
            ),
            onTap: () async {
              try {
                BlocProvider.of<AudioPlayerBloc>(context)
                    .add(PlaySongEvent(appSongModel: state.songs[index]));
              } catch (e) {
                log(e.toString());
              }
              showBottomSheet(
                  backgroundColor: ColorConstants.darkBlueColor,
                  context: context,
                  builder: (ctx) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PlayScreen(
                            songs: state.songs,
                            index: index,
                            isFav: state.songs[index].isFavourite,
                          );
                        }));
                      },
                      child: MiniPlayerWidget(
                        songs: state.songs,
                        index: index,
                      ),
                    );
                  });
            },
          ),
        );
      },
      itemCount: state.songs.length,
    );
  }
}
