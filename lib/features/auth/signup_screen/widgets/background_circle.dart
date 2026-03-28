import 'package:flutter/material.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 320,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [Colors.white, AppColors.primaryColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter),
      ),
    );
  }
}
