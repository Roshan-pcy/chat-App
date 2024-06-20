import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? isMe() {
    return auth.currentUser;
  }

  Future<UserCredential> signInWithGmail(String email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> createSignInWithGmail(String email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
