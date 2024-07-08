// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      _showToast(e.toString());
    }
    return null;
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      _showToast('Logged in');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await auth.signOut();
    _showToast('Logged out');
  }

  // Get current user
  User? getUser() {
    return auth.currentUser;
  }

  // Check if email is registered
  Future<bool> isEmailRegistered(String email) async {
    try {
      // TODO: Look for an alternative
      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(email.trim());
      return signInMethods.isNotEmpty;
    } catch (e) {
      _showToast(e.toString());
      return false;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/userinfo.profile');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // TODO: Setup Signin with redirect

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    return userCredential.user;
  }

  // Handle Firebase authentication exceptions
  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      _showToast('Weak password');
    } else if (e.code == 'email-already-in-use') {
      _showToast('Email already in use');
    } else if (e.code == 'user-not-found') {
      _showToast('No user found');
    } else if (e.code == 'wrong-password') {
      _showToast('Wrong password');
    } else {
      _showToast(e.message ?? 'An error occurred');
    }
  }

  // Show a toast message
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
