import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/constants/color_constants.dart';
import 'package:music_player/constants/text_constants.dart';
import 'package:music_player/presentation/blocs/home_screen_bloc/homescreen_bloc.dart';
import '../../constants/text_styles.dart';
import '../widgets/songs_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                TextConstants.homeText,
                style: TextStyles.poppinsW700S24CWhite,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstants.darkVioletColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      TextConstants.albumText,
                      style: TextStyles.poppinsW400S14CWhite,
                    ),
                    Text(TextConstants.playListsText,
                        style: TextStyles.poppinsW400S14CWhite),
                    Text(TextConstants.settingsText,
                        style: TextStyles.poppinsW400S14CWhite),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 25,
                right: 25,
                bottom: 20.0,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  // prefixIcon: SvgPicture.asset('assets/images/search.svg'),
                  fillColor: ColorConstants.lightBlackColor,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: ColorConstants.lightGreyColor,
                  ),
                  hintText: 'search',
                  hintStyle: TextStyle(
                    color: ColorConstants.lightGreyColor,
                    fontSize: 15,
                  ),
                  contentPadding: const EdgeInsets.only(bottom: 30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    TextConstants.mySongsText,
                    style: TextStyles.poppinsW700S24CWhite,
                  ),
                ),
              ],
            ),
            Expanded(child: BlocBuilder<HomescreenBloc, HomescreenState>(
              builder: (context, state) {
                if (state is HomescreenInitial) {
                  BlocProvider.of<HomescreenBloc>(context)
                      .add(FetchMusicEvent());
                }
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FailureState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is LoadedState) {
                  if (state.songs.isEmpty) {
                    return Center(
                      child: Text(
                        'Add some Songs in your phone',
                        style: TextStyles.poppinsW400S18CWhite,
                      ),
                    );
                  }
                  return SongsListWidget(
                    state: state,
                  );
                }
                return Container();
              },
            )),
          ],
        ),
      ),
    );
  }
}
