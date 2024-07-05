// ignore_for_file: unused_import

import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learners\' Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const AuthWrapper(),

      // initialRoute: '/login',
      //
      // routes: {
      //   '/login': (context) => const Login(),
      //   '/signup': (context) => const Signup(),
      //   // '/home': (context) => const Home(),
      //   // '/settings': (context) => const Settings(),
      //   // '/transition': (context) => const TransitionPage(),
      //   // '/onboarding': (context) => const Onboarding(),
      //   // '/transition': (context) => const TransitionPage(),
      //   // '/onboarding': (context) => const Onboarding(),
      //   // '/welcome' : (context) => const WelcomePageOne(),
      //   // '/profile' : (context) => const Profile(),
      //   // '/trial': (context) => const Trial(),
      // },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Lottie.network(
                    'https://lottie.host/ae9cc085-4db3-49e6-8aa6-47e89cd693ad/ULVww8ZhqK.json',
                    fit: BoxFit.contain),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return const Home();
        } else {
          return const Login();
        }
      },
    );
  }
}
