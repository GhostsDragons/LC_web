import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lc_web/Pages/home.dart';
import 'package:lottie/lottie.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({super.key});

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  final List<String> animationUrls = [
    'https://lottie.host/cd71aca9-d707-466c-92e3-2c78f9995160/BvfvtJ3M7o.json',
    'https://lottie.host/5b316198-bcc2-430d-bac1-dff2617327e5/DaTRDfIqS2.json',
    'https://lottie.host/43a51589-4a7e-4da5-8b3f-af0cd4d7b974/N5Ol1voZlf.json',
  ];

  final List<String> randomTexts = [
    "Learning redefined",
    "Let's make learning fun !",
    "Discover new possibilities!",
  ];

  late String _selectedAnimationUrl;
  late String _selectedText;

  @override
  void initState() {
    super.initState();

    _selectedAnimationUrl = animationUrls[Random().nextInt(animationUrls.length)];
    _selectedText = randomTexts[Random().nextInt(randomTexts.length)];

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileLayout(constraints: constraints, animationUrl: _selectedAnimationUrl, text: _selectedText);
        } else {
          return DesktopLayout(constraints: constraints, animationUrl: _selectedAnimationUrl, text: _selectedText);
        }
      },
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final BoxConstraints constraints;
  final String animationUrl;
  final String text;
  const DesktopLayout({super.key, required this.constraints, required this.animationUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Lottie.network(
                animationUrl,
                fit: BoxFit.contain
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Center(  
                child: Text(
                  text, 
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  final BoxConstraints constraints;
  final String animationUrl;
  final String text;
  const MobileLayout({super.key, required this.constraints, required this.animationUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Lottie.network(
                animationUrl,
                fit: BoxFit.contain
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                text, 
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}