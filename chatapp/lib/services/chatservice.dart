import 'package:chatapp/model/chatmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //get instence of firestore & auth  instence
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // get suer stream

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firebaseFirestore.collection('users').snapshots().map(
      (event) {
        return event.docs.map(
          (e) {
            final user = e.data();
            return user;
          },
        ).toList();
      },
    );
  }

//send message
  Future<void> sendMessage(String reciverId, String messages) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentEmail = firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    final Messageclass messageclass = Messageclass(
        message: messages,
        reciverId: reciverId,
        senderEmail: currentEmail,
        senderID: currentUserId,
        timestamp: timestamp);
    List<String> list = [reciverId, currentUserId];
    list.sort();
    String chatRoom = list.join('_');

    await firebaseFirestore
        .collection('chat_room')
        .doc(chatRoom)
        .collection('message')
        .add(messageclass.toMap());
  }

//get message

  Stream<QuerySnapshot> getMessage(String userid, String otherUserId) {
    // final String currentUserId = firebaseAuth.currentUser!.uid;
    // final String currentEmail = firebaseAuth.currentUser!.email!;
    // final Timestamp timestamp = Timestamp.now();

    // final Messageclass messageclass = Messageclass(
    //     message: message,
    //     reciverId: reciverId,
    //     senderEmail: currentEmail,
    //     senderID: currentUserId,
    //     timestamp: timestamp);
    List<String> list = [userid, otherUserId];
    list.sort();
    String chatRoom = list.join('_');

    return firebaseFirestore
        .collection('chat_room')
        .doc(chatRoom)
        .collection('message')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
