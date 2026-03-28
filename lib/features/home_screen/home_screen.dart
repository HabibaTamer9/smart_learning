import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        CustomButton(text: "Sign out", onPressed: ()async{await FirebaseAuth.instance.signOut();})
        ]
      ),
    );
  }
}
