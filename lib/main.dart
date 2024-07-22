// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:lc_web/Pages/course_catalog.dart';
import 'package:lc_web/Pages/home.dart';
// import 'package:lc_web/Pages/settings.dart';
import 'package:lc_web/Pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:lc_web/Pages/welcome_1.dart';
import 'package:lc_web/firebase_options.dart';
import 'package:lottie/lottie.dart';

// TODO: Add mobile application integration
// TODO: Setup Theme data
// TODO:

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var user = Auth().getUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learners\' Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home:(user != null)? const Home(): const Login(),

    );
  }
}