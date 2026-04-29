import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get userStream => firebaseAuth.authStateChanges();

  Future<User?> signUp(String email, String password, String userName) async {
    try {
      final UserCredential cred = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'userName': userName,
        'email': email,
        'cart': [],
      });
      return cred.user!;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Sign up Failed');
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Login failed");
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<DocumentSnapshot?> getUser() async {
    final user = FirebaseAuth.instance.currentUser;

    // ✅ Check if user is null (Guest) BEFORE using it
    if (user == null) {
      return null;
    }

    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
    } catch (e) {
      return null;
    }
  }
}
