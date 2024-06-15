import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lc_web/Pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      appBar: AppBar(
        backgroundColor:const Color(0xFF1F3E3C),
      ),

      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle_rounded,
            size: 200,
          ),
      
          Text(
            'Welcome name',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold
            ),
          ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Grade',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
              ),
          
              Text(' | '),
          
              Text(
                'Board',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
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