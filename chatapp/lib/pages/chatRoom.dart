import 'package:chatapp/classs/FirebaseAuth.dart';
import 'package:chatapp/componets/TextEdit.dart';
import 'package:chatapp/services/chatservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final String name;
  final String uid;
  final TextEditingController _sendController = TextEditingController();
  ChatRoom({super.key, required this.name, required this.uid});
  //auth and chat instence

  final Auth auth = Auth();
  final ChatService chatRoom = ChatService();

  void sendMessage() async {
    if (_sendController.text.isNotEmpty) {
      chatRoom.sendMessage(uid, _sendController.text);
      _sendController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [Expanded(child: _buiderView()), _userInput()],
      ),
    );
  }

  Widget _buiderView() {
    final userId = auth.isMe()!.uid;
    return StreamBuilder(
      stream: chatRoom.getMessage(userId, uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        print(snapshot.data!.docs.length);

        return ListView(
          children: snapshot.data!.docs
              .map(
                (value) => _showMessageWidget(value),
              )
              .toList(),
        );
      },
    );
  }

  Widget _showMessageWidget(DocumentSnapshot value) {
    // Map<String, dynamic> data = value.data() as Map<String, dynamic>;
    // print(data['senderEmial']);
    return Text('hello');
  }

  Widget _userInput() {
    return Row(
      children: [
        Expanded(
            child: Mytextfiled(
          controller: _sendController,
          hinttext: 'Type message',
          obsecure: false,
        )),
        IconButton(
            onPressed: () => sendMessage(),
            icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
