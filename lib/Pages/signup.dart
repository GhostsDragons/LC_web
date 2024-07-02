import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:lc_web/Functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lc_web/Pages/onboarding.dart';

// TODO: Link to terms and Services and Privacy Policy
// TODO: Login Button

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();

  bool loading = false;
  var email = "";
  var password = "";
  var repeat = "";

  void handleSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    email = emailController.value.text;
    password = passController.value.text;
    repeat = confPassController.text;

    setState(() {
      loading = true;
    });

    if (repeat == password) {
      final User? user =
          await Auth().registerWithEmailAndPassword(email, password);
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!doc.exists) {
          _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'createdOn': DateTime.now(),
          });
        }

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Onboarding()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileLayout(
            constraints: constraints,
            emailController: emailController,
            passController: passController,
            confPassController: confPassController,
            formKey: formKey,
            handleSubmit: handleSubmit,
            loading: loading,
            isMobile: true,
          );
        } else {
          return MobileLayout(
            constraints: constraints,
            emailController: emailController,
            passController: passController,
            confPassController: confPassController,
            formKey: formKey,
            handleSubmit: handleSubmit,
            loading: loading,
            isMobile: false,
          );
        }
      },
    );
  }
}

// ---------------------------------------------------------------------------------------
// Mobile Layout
// ---------------------------------------------------------------------------------------

class MobileLayout extends StatefulWidget {

  final BoxConstraints constraints;
  final TextEditingController emailController,
      passController,
      confPassController;
  final GlobalKey<FormState> formKey;
  final Function() handleSubmit;
  final bool loading, isMobile;

  const MobileLayout({
    super.key,
    required this.constraints,
    required this.emailController,
    required this.passController,
    required this.confPassController,
    required this.formKey,
    required this.handleSubmit,
    required this.loading,
    required this.isMobile,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xddffffff), Color(0xdd1f3e3c)],
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
                        Visibility(
                          visible: widget.isMobile,
                          child: SizedBox(
                            width: widget.constraints.maxWidth / 1.5,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Learners’ \nClub',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.unbounded(
                                  textStyle: const TextStyle(
                                    fontFamily: 'Unbounded',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 70,
                                    color: Color(0xff1F3E3C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        // Learning Unbounded
                        Visibility(
                          visible: widget.isMobile,
                          child: SizedBox(
                            width: widget.constraints.maxWidth / 2,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Learning Unbounded',
                                style: GoogleFonts.unbounded(
                                  textStyle: const TextStyle(
                                    fontSize: 30,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0x991F3E3C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 30),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      width: widget.isMobile
                          ? null
                          : widget.constraints.maxWidth / 3,
                      child: Form(
                        key: widget.formKey,
                        child: Column(
                          children: [
                            // Signup
                            Text(
                              "Signup",
                              style: GoogleFonts.unbounded(
                                textStyle: const TextStyle(
                                  fontSize: 40,
                                  color: Color(0xff1F3E3C),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Text(
                              "Create an Account",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  color: Color(0xff1F3E3C),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            Text(
                              "Seems like you do not have an account",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  color: Color(0xff1F3E3C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            // Email ID
                            FormInput(
                              textController: widget.emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email Address',
                              hint: 'email@domain.com',
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Password
                            FormInput(
                              textController: widget.passController,
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
                              textController: widget.confPassController,
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
                              onPressed: () => widget.handleSubmit(),
                              child: widget.loading
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sign up with Email',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
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
                              height: 20,
                            ),
                          ],
                        ),
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
