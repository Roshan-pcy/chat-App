import 'package:cloud_firestore/cloud_firestore.dart';

class Messageclass {
  final String senderID;
  final String senderEmail;
  final String reciverId;
  final String message;
  final Timestamp timestamp;
  const Messageclass(
      {required this.message,
      required this.reciverId,
      required this.senderEmail,
      required this.senderID,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmial': senderEmail,
      'reciverId': reciverId,
      'message': message,
      'timesstamp': timestamp
    };
  }
}
