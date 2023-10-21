import 'package:flutter/material.dart';
import 'package:just_play_test/src/ui/home_screen/home_screen.dart';
import 'package:just_play_test/src/ui/login_screen/login_screen.dart';
import '../../../global_locator.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../services/navigation_service.dart';
import '../../theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/static/icon_path.dart';
import '../../widgets/images/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AuthBloc authBloc = AuthBloc();
  late Animation<double> animation;
  late AnimationController animationController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  @override
  void initState() {
    authBloc = global<AuthBloc>();
    authBloc.add(AuthValidateEvent());
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).unfocus();
    });
    _animationController(begin: 0.0, end: 0.9);
    animationController.forward();
    super.initState();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _animationController(
      {int? duration, required double begin, required double end}) {
    animationController = AnimationController(
        duration: Duration(milliseconds: duration ?? 800), vsync: this);
    animation = Tween(begin: begin, end: end).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) async {
          if (state is AuthAuthenticatedState) {
            authBloc.add(AuthInitialEvent());
            _animationController(begin: 0.9, end: 1.0);
            await animationController.forward().then(
                  (value) => {
                    NavigationService.pushAndRemoveUntil(
                      context: context,
                      screen: HomeScreen(),
                      routeName: HomeScreen.routeName,
                    )
                  },
                );
          }
          if (state is AuthNoAuthenticatedState) {
            _animationController(begin: 0.9, end: 1.0);
            await animationController.forward().then(
                  (value) => {
                    NavigationService.pushAndRemoveUntil(
                        context: context,
                        screen: LoginScreen(),
                        routeName: LoginScreen.routeName)
                  },
                );
          }
          if (state is AuthFinishWithError) {
            _animationController(begin: 0.9, end: 1.0);
            await animationController.forward().then(
                  (value) => {
                    NavigationService.pushAndRemoveUntil(
                        context: context,
                        screen: LoginScreen(),
                        routeName: LoginScreen.routeName)
                  },
                );
          }
        },
        child: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomImage(
                      image: AssetsData.logoJustPlay,
                      height: size.height * 0.16,
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: size.width * 0.4,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          minHeight: 5.0,
                          value: animation.value,
                          color: AppColors.white,
                          backgroundColor: AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
