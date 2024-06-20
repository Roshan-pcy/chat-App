import 'package:chatapp/classs/FirebaseAuth.dart';
import 'package:chatapp/componets/TextEdit.dart';
import 'package:chatapp/componets/button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _gmailContrller = TextEditingController();

  final TextEditingController _passwordContrller = TextEditingController();
  void logIn(BuildContext context) {
    final Auth auth = Auth();

    try {
      auth.signInWithGmail(_gmailContrller.text, _passwordContrller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
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
              Icons.message_outlined,
              size: 70,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Welcome to Chat It',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            Mytextfiled(
              controller: _gmailContrller,
              hinttext: 'Gmail',
              obsecure: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Mytextfiled(
              controller: _passwordContrller,
              hinttext: 'password',
              obsecure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Costombutton(
              onTap: () => logIn(context),
              text: 'Log in',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a Memeber ? '),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      ' Register Now',
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
