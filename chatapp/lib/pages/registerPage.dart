import 'package:chatapp/classs/FirebaseAuth.dart';
import 'package:chatapp/componets/TextEdit.dart';
import 'package:chatapp/componets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Registerscreen extends StatefulWidget {
  void Function()? onTap;
  Registerscreen({super.key, required this.onTap});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController gmailContrller = TextEditingController();

  final TextEditingController passwordContrller = TextEditingController();

  final TextEditingController confpasswordContrller = TextEditingController();
  void register(BuildContext context) async {
    final Auth auth = Auth();
    if (passwordContrller.text == confpasswordContrller.text) {
      try {
        await auth.createSignInWithGmail(
            gmailContrller.text, passwordContrller.text);
      } on FirebaseException catch (e) {
        showDialog(
          context: context,
          builder: (context1) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("passowrd missmatch"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              color: Theme.of(context).colorScheme.primary,
              Icons.app_registration,
              size: 70,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Register now',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            Mytextfiled(
              controller: gmailContrller,
              hinttext: 'Gmail',
              obsecure: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Mytextfiled(
              controller: passwordContrller,
              hinttext: 'password',
              obsecure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Mytextfiled(
              controller: confpasswordContrller,
              hinttext: 'confirm password',
              obsecure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Costombutton(
              onTap: () => register(context),
              text: 'Register',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'alredy log in? ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      '  Log in',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
