// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // Auth() {
  //   _initializeFirebase();
  // }

  // Initialize Firebase
  // Future<void> _initializeFirebase() async {
  //   await Firebase.initializeApp();
  //   auth.setPersistence(Persistence.LOCAL);
  // }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
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
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
    return userCredential.user;

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);


  }
    // try {
  //   //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //   //   if (googleUser == null) return null;
  //   //
  //   //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   //
  //   //   final AuthCredential credential = GoogleAuthProvider.credential(
  //   //     accessToken: googleAuth.accessToken,
  //   //     idToken: googleAuth.idToken,
  //   //   );
  //   //
  //   //   UserCredential userCredential = await auth.signInWithCredential(credential);
  //   //   _showToast('Logged in with Google');
  //   //   return userCredential.user;
  //   // } catch (e) {
  //   //   print(e);
  //   //   _showToast('Google sign-in failed');
  //   //   return null;
  //   // }
  //   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication?.accessToken,
  //     idToken: googleSignInAuthentication?.idToken,
  //   );
  //
  //   final UserCredential userCredential = await auth.signInWithCredential(credential);
  //   final User? user = userCredential.user;
  //
  //   if (user != null) {
  //     // Checking if email and name is null
  //     assert(user.uid != null);
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(user.photoURL != null);
  //
  //     var uid = user.uid;
  //     var name = user.displayName;
  //     var userEmail = user.email;
  //     var imageUrl = user.photoURL;
  //
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //
  //     final User? currentUser = auth.currentUser;
  //     assert(user.uid == currentUser?.uid);
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('auth', true);
  //
  //     return currentUser;
  //   }
  //
  //   return null;
  // }
  //
  // void signOutGoogle() async {
  //   await googleSignIn.signOut();
  //   await auth.signOut();
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('auth', false);
  //
  //   // uid = null;
  //   // name = null;
  //   // userEmail = null;
  //   // imageUrl = null;
  //
  //   print("User signed out of Google account");
  // }

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
