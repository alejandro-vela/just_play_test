import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_play_test/firebase_options.dart';
import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/bloc/observer_bloc.dart';

import 'src/theme/theme.dart';
import 'src/ui/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ObserverBloc();
  setUpGlobalLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JustPlayApp());
}

class JustPlayApp extends StatelessWidget {
  const JustPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Just Play',
      theme: lightThemeData,
      home: SplashScreen(),
    );
  }
}
