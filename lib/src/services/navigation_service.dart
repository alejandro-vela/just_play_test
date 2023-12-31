import 'package:flutter/material.dart';

class NavigationService {
  static pop(BuildContext context, {bool? result = true}) {
    return Navigator.pop(context, result);
  }

  static Future<void> push({
    required BuildContext context,
    required Widget screen,
    required String routeName,
  }) {
    return Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: routeName),
          builder: (context) => screen,
        ),
      );
    });
  }

  static pushAndRemoveUntil({
    required BuildContext context,
    required Widget screen,
    required String routeName,
  }) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: routeName),
          builder: (context) => screen,
        ),
        (route) => false);
  }

  static pushAndRemoveUntilRouteName({
    required BuildContext context,
    required Widget screen,
    required String routeName,
    required String untilRouteName,
  }) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          settings: RouteSettings(name: routeName),
          builder: (context) => screen,
        ),
        ModalRoute.withName(untilRouteName));
  }

  static popUntil(BuildContext context, String routeName) {
    return Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
