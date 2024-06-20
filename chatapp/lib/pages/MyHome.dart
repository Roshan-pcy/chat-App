import 'package:chatapp/classs/FirebaseAuth.dart';
import 'package:chatapp/componets/drawer.dart';
import 'package:flutter/material.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerUi(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final auth = Auth();
                auth.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text('Chat Kit'),
      ),
    );
  }
}
