import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // **Sign up with Email and Password**
  Future<String> signUpWithEmailPassword(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "User Register Successfully"; // Return the authenticated user
    } on FirebaseAuthException catch (e) {
      log('SignUp Error: ${e.message}');
      return e.message ?? "Faild to Signup"; // Return null if there is an error
    }
  }

  // **Login with Email and Password**
  Future<String> loginWithEmailPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "User Login Successfully"; // Return the authenticated user
    } on FirebaseAuthException catch (e) {
      log('Login Error: ${e.message}');
      return e.message ?? "Login Faild"; // Return null if there is an error
    }
  }


Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      return "Google Login  Successful";
    } on Exception catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
  // **Store User Data in Firestore**
  Future<String> storeUserData({required  String userId, required Map<String, dynamic> userData}) async {

    try {
      await firebaseFirestore.collection('users').doc(userId).set(userData);
      
      log('User data stored successfully!');
      return "User data stored successfully!";
    } catch (e) {
      log('Error storing user data: $e');
      return e.toString();
    }
  }
}
