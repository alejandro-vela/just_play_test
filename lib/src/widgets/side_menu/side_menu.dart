import 'package:flutter/material.dart';
import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/bloc/auth/auth_bloc.dart';
import 'package:just_play_test/src/services/navigation_service.dart';
import 'package:just_play_test/src/theme/colors.dart';
import 'package:just_play_test/src/ui/cities/cities.dart';
import 'package:just_play_test/src/ui/login_screen/login_screen.dart';
import 'package:just_play_test/src/widgets/images/custom_image.dart';

import '../../services/firebase_services.dart';
import '../../utils/lang/capitalized.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Row(
              children: [
                CustomImage(
                  image: global<AuthBloc>().user?.photoURL ?? '',
                  height: 30,
                  borderRadius: 30,
                ),
                SizedBox(width: 10),
                Text(
                  global<AuthBloc>().user?.displayName?.capitalize() ?? 'User',
                  style: TextStyle(color: AppColors.white, fontSize: 25),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Ciudad'),
            onTap: () => {
              Navigator.of(context).pop(),
              NavigationService.push(
                  context: context,
                  screen: CitiesScreen(),
                  routeName: CitiesScreen.routeName)
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              NavigationService.pushAndRemoveUntil(
                  context: context,
                  screen: LoginScreen(),
                  routeName: LoginScreen.routeName),
              AuthFirebaseCustom().signOut(),
            },
          ),
        ],
      ),
    );
  }
}
