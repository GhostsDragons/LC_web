import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lc_web/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({super.key});

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  // final String name;
  // final String grade;
  // final String board;

  // _TransitionPageState(this.grade, this.board, this.name);


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      // Navigate to the next page after 5 seconds
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text('Hi');
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return MobileLayout(constraints: constraints);
              } else {
                return DesktopLayout(constraints: constraints);
              }
            },
          );
        }
      },
    );
  }
}

class DesktopLayout extends StatefulWidget {
  final BoxConstraints constraints;
  const DesktopLayout({super.key, required this.constraints});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Lottie.network(
            'https://lottie.host/cd71aca9-d707-466c-92e3-2c78f9995160/BvfvtJ3M7o.json',
            fit: BoxFit.contain
          ),
        ),
      ),
    );
  }
}


class MobileLayout extends StatefulWidget {
  final BoxConstraints constraints;
  const MobileLayout({super.key, required this.constraints});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}