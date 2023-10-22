import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_play_test/src/bloc/auth/auth_bloc.dart';
import 'package:just_play_test/src/utils/static/icon_path.dart';
import 'package:just_play_test/src/widgets/buttons/google.dart';

import '../../../global_locator.dart';
import '../../services/navigation_service.dart';
import '../../widgets/images/custom_image.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: global<AuthBloc>(),
      listener: (context, state) async {
        if (state is AuthAuthenticatedState) {
          NavigationService.pushAndRemoveUntil(
            context: context,
            screen: HomeScreen(),
            routeName: HomeScreen.routeName,
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsData.soccer),
                fit: BoxFit.cover,
                opacity: .2),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  image: AssetsData.logoJustPlay,
                  borderRadius: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                GoogleSignInButton(onPressed: () {
                  global<AuthBloc>().add(AuthLoginEvent());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
