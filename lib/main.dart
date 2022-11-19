import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:music_player/presentation/blocs/home_screen_bloc/homescreen_bloc.dart';
import 'package:music_player/presentation/screens/home_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => kiwi.KiwiContainer().resolve<HomescreenBloc>(),
        ),
        BlocProvider(
          create: (context) => kiwi.KiwiContainer().resolve<AudioPlayerBloc>(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
