import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Pages/transition_page.dart';
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
  String? _grade;
  String? _board;

  final List<String> boardOptions = ['CBSE', 'ICSE', 'IGCSE', 'SSC'];
  final List<String> gradeOptions = ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'];

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

                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: _gradeDropDown(underline: Container())),

                      const SizedBox(height: 10.0),

                      Container(
                          padding: const EdgeInsets.all(8.0),
                          // width: 400,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: _boardDropDown(underline: Container())),

                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TransitionPage(
                                  // name: _name,
                                  // grade: _grade,
                                  // board: _board,
                                  ),
                            ),
                          );
                        },
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
            child: Container(
              color: const Color(0xFF1F3E3C),
              child: const Center(
                child: Image(
                  image: AssetImage('assets/onboarding_side.jpg')
                )
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _gradeDropDown({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _grade,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _grade = newValue;
            });
          },
          hint: Text("Select your grade", style: hintStyle),
          items: gradeOptions
              .map((grade) =>
                  DropdownMenuItem<String>(value: grade, child: Text(grade)))
              .toList());

  Widget _boardDropDown({
    Widget? underline,
    Widget? icon,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _board,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: style,
          iconEnabledColor: iconEnabledColor,
          onChanged: (String? newValue) {
            setState(() {
              _board = newValue;
            });
          },
          hint: Center(
            child: Text("Select your board",
              style: hintStyle, 
              ),
          ),
          items: boardOptions
              .map((board) =>
                  DropdownMenuItem<String>(value: board, child: Text(board)))
              .toList());
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


