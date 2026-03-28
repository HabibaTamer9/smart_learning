import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({super.key, required this.child, this.onTap});
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(11),
          margin: EdgeInsets.all(5),
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECEFF6),width: 2),
              borderRadius: BorderRadius.circular(12)
          ),
          child: child,
        ),
      ),
    );
  }
}
