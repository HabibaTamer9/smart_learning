import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.buttonColor = Colors.deepPurple,
      this.textColor = Colors.white,
      required this.text,
      this.onPressed});

  final Color buttonColor;
  final Color textColor;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: buttonColor,
        height: 60,
        minWidth: MediaQuery.of(context).size.width * 0.9,
        textColor: textColor,
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
