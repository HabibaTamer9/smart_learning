import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 25.0, right: 30, bottom: 15),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Color(0xff1E232C)),
      ),
    );
  }
}
