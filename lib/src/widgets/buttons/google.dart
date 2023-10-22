import 'package:flutter/material.dart';
import 'package:just_play_test/src/theme/colors.dart';
import 'package:just_play_test/src/utils/static/icon_path.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function() onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Image.asset(
        AssetsData.logoGoogle,
        width: 24.0,
      ),
      label: Text(
        'Iniciar sesión con Google',
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: BorderSide(color: AppColors.secondaryColor.withOpacity(.3)),
      ),
      onPressed: onPressed,
    );
  }
}
