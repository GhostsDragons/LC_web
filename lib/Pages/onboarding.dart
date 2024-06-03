import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import '../Functions/functions.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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

  List<String> boardOptions = ['CBSE', 'ICSE', 'IGCSE','SSC'];
  List<String> gradeOptions = ['Grade 9', 'Grade 10', 'Grade 11','Grade 12'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF1F3E3C),
              child: Center(
                child: Container(
                  width: 600,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tell us more about yourself',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 40.0),

                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(text: 'Name'),
                        ]),
                        textAlign: TextAlign.left,
                      ),

                      const SizedBox(width: 20.0),

                      TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) => setState(() => name = value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10.0),

                      DropdownButton<String>(
                        value: grade,
                        hint: const Text('Select Grade'),
                        items: gradeOptions.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        )).toList(),
                        onChanged: (value) => setState(() => grade = value!),
                      ),

                      const SizedBox(height: 10.0),

                      DropdownButton<String>(
                        value: board,
                        hint: const Text('Select Board'),
                        items: boardOptions.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        )).toList(),
                        onChanged: (value) => setState(() => board = value!),
                      ),

                      const SizedBox(height: 10.0),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ---------------------------------------------------------------------------------------
          // Right hand side
          // ---------------------------------------------------------------------------------------
          
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_rounded,
                          size: 200,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Hello there, $name',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$grade',
                          style: const TextStyle(fontSize: 20),
                        ),
                        
                        const Text(' | ', style: TextStyle(fontSize: 25),),

                        Text(
                          '$board',
                          style: const TextStyle(fontSize: 20)
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
