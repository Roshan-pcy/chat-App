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
      stream: chatRoom.getMessage(uid, userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No message'));
        }

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
    Map<String, dynamic> data = value.data() as Map<String, dynamic>;

    bool isme = data['senderEmial'] == auth.isMe()!.email;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: isme ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: isme ? Radius.circular(0) : Radius.circular(10)),
              color: isme
                  ? Color.fromARGB(255, 68, 68, 200)
                  : Color.fromARGB(255, 132, 18, 103)),
          child: Text(
            data['message'],
          )),
    );
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
