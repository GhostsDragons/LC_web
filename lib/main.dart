import 'package:flutter/material.dart';
// import 'package:learners_club/Pages/profile.dart';
// import 'package:learners_club/Pages/signup.dart';
// import 'package:learners_club/Pages/home.dart';
// import 'package:learners_club/Pages/settings.dart';
import 'package:lc_web/Pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:learners_club/Pages/welcome_1.dart';
import 'package:lc_web/firebase_options.dart';
// import 'package:learners_club/Pages/transition_page.dart';
// import 'Pages/onboarding.dart';

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
      title: 'Learners Club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        // '/signup': (context) => Signup(),
        // '/home': (context) => const HomePage(),
        // '/settings': (context) => const Settings(),
        // '/transition': (context) => const TransitionPage(),
        // '/onboarding': (context) => const Onboarding(),
        // '/welcome' : (context) => const WelcomePageOne(),
        // '/profile' : (context) => const Profile(),
      },
    );
  }
}
