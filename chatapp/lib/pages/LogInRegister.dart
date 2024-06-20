import 'package:chatapp/pages/logInPage.dart';
import 'package:chatapp/pages/registerPage.dart';
import 'package:flutter/material.dart';

class LogOrRegister extends StatefulWidget {
  const LogOrRegister({super.key});

  @override
  State<LogOrRegister> createState() => _LogOrRegisterState();
}

class _LogOrRegisterState extends State<LogOrRegister> {
  bool islogin = true;
  void setWidgets() {
    setState(() {
      islogin = !islogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: islogin
            ? LoginPage(onTap: setWidgets)
            : Registerscreen(
                onTap: setWidgets,
              ));
  }
}
