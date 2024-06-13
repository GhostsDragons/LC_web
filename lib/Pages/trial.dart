import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Trial extends StatefulWidget {
  const Trial({super.key});

  @override
  State<Trial> createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text('Hi');
        } else {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return MobileLayout(constraints: constraints);
            } else {
              return DesktopLayout(constraints: constraints);
            }
          });
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
  String? name;
  String? grade;
  String? board;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xFF1F3E3C),
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFFFFFF),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tell us more about yourself',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),

                            // Expanded(
                            //   child: TextFormField(
                            //     decoration: InputDecoration(
                            //       labelText: 'Name',
                            //       hintText: 'Enter your full name',
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         borderSide: const BorderSide(
                            //           color: Colors.grey,
                            //         ),
                            //       ),
                            //     ),
                            //     onChanged: (value) => setState(() => name = value),
                            //     validator: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return 'Please enter your name';
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 200,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'name goes here',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Grade goes here',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(' | '),
                      Text('Board goes here', style: TextStyle(fontSize: 20)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
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
