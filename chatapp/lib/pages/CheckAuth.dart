import 'package:chatapp/pages/LogInRegister.dart';
import 'package:chatapp/pages/MyHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checkauth extends StatelessWidget {
  const Checkauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Myhome();
          }

          return const LogOrRegister();
        },
      ),
    );
  }
}
