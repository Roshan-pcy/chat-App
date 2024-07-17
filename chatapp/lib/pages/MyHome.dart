import 'package:chatapp/classs/FirebaseAuth.dart';
import 'package:chatapp/componets/UserUI.dart';
import 'package:chatapp/componets/drawer.dart';
import 'package:chatapp/pages/chatRoom.dart';
import 'package:chatapp/services/chatservice.dart';
import 'package:flutter/material.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  final ChatService chatService = ChatService();
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerUi(),
      appBar: AppBar(
        backgroundColor: Colors.green,
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
      body: StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
              children:
                  snapshot.data!.map((e) => _listWidget(e, context)).toList());
        },
      ),
    );
  }

  Widget _listWidget(Map<String, dynamic> userdata, BuildContext context) {
    if (userdata['email'] != auth.isMe()!.email) {
      return UserUi(
        username: userdata['email'],
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                name: userdata['email'],
                uid: userdata['uid'],
              ),
            )),
      );
    } else {
      return const SizedBox();
    }
  }
}
