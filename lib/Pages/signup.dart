import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Functions/functions.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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

// ---------------------------------------------------------------------------------------
// Desktop Layout
// ---------------------------------------------------------------------------------------

class DesktopLayout extends StatefulWidget {
  final BoxConstraints constraints;
  const DesktopLayout({super.key, required this.constraints});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/BG.jpg'),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
            color: Color.fromRGBO(0, 0, 0, 0.9),
            gradient: LinearGradient(
              colors: [Color(0xffffffff), Color(0xff1F3E3C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white54,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            width: widget.constraints.maxWidth / 3,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Signup
                    const Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Unbounded',
                        color: Color(0xff1F3E3C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        color: Color(0xff1F3E3C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Text(
                      "Seems like you do not have an account",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xff1F3E3C),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    FormInput(
                      textController: emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email Address',
                      hint: 'email@domain.com',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    FormInput(
                      textController: pass1Controller,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Password',
                      hint: 'Enter your password',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    FormInput(
                      textController: pass2Controller,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1F3E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sign up with Email',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          // You Agree
                          TextSpan(
                            text: 'By clicking Continue, you agree to our ',
                            style: TextStyle(
                              color: Color(0xFF828282),
                            ),
                          ),

                          // Services
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: Color(0xFF1F3E3C),
                              decoration: TextDecoration.underline,
                            ),
                          ),

                          // And
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Color(0xFF828282),
                            ),
                          ),

                          // Privicy Policy
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                color: Color(0xFF1F3E3C),
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

// ---------------------------------------------------------------------------------------
// Mobile Layout
// ---------------------------------------------------------------------------------------

class MobileLayout extends StatefulWidget {
  final BoxConstraints constraints;
  const MobileLayout({super.key, required this.constraints});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
              color: Color.fromRGBO(0, 0, 0, 0.9),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff1F3E3C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        // Learners' Club
                        SizedBox(
                          width: widget.constraints.maxWidth / 1.5,
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Learners’ \nClub',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Unbounded',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 70,
                                  color: Color(0xff1F3E3C)),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        SizedBox(
                          width: widget.constraints.maxWidth / 2,
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Learning Unbounded',
                              style: TextStyle(
                                  fontFamily: 'Unbounded',
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0x991F3E3C)),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white54,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Signup
                          const Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Unbounded',
                              color: Color(0xff1F3E3C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          const Text(
                            "Create an Account",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              color: Color(0xff1F3E3C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const Text(
                            "Seems like you do not have an account",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xff1F3E3C),
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Email ID
                          FormInput(
                            textController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            hint: 'email@domain.com',
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Password
                          FormInput(
                            textController: pass1Controller,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'Password',
                            hint: 'Enter password',
                            obsTxt: true,
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Confirm Password
                          FormInput(
                            textController: pass2Controller,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'Confirm Password',
                            hint: 'Confrim password',
                            obsTxt: true,
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Signup Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1F3E3C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign up with Email',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // Terms and Conditions
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                // You Agree
                                TextSpan(
                                  text:
                                      'By clicking Continue, you agree to our ',
                                  style: TextStyle(
                                    color: Color(0xFF828282),
                                  ),
                                ),

                                // Services
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: Color(0xFF1F3E3C),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),

                                // And
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                    color: Color(0xFF828282),
                                  ),
                                ),

                                // Privicy Policy
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      color: Color(0xFF1F3E3C),
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
