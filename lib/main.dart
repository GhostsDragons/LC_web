import 'package:flutter/material.dart';
// import 'package:lc_web/Pages/profile.dart';
import 'package:lc_web/Pages/signup.dart';
// import 'package:lc_web/Pages/home.dart';
// import 'package:lc_web/Pages/settings.dart';
import 'package:lc_web/Pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:lc_web/Pages/welcome_1.dart';
import 'package:lc_web/firebase_options.dart';
// import 'package:lc_web/Pages/transition_page.dart';
import 'package:lc_web/Pages/onboarding.dart';
// import 'package:lc_web/Pages/trial.dart';

import 'Firebase/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Auth().signOut();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Learners Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/login',

      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        // '/home': (context) => const HomePage(),
        // '/settings': (context) => const Settings(),
        // '/transition': (context) => const TransitionPage(),
        '/onboarding': (context) => const Onboarding(),
        // '/welcome' : (context) => const WelcomePageOne(),
        // '/profile' : (context) => const Profile(),
        // '/trial': (context) => ParentWidget(),
      },
    );
  }
}
