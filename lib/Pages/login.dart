import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Pages/home.dart';
import 'package:lc_web/Pages/onboarding.dart';
import 'package:lc_web/Functions/widgets.dart';

// TODO: Forgot Password
// TODO: Optimize the code
// TODO: Link to terms and Services and Privacy Policy
// TODO: Fix the Coursel Slider for narrow screens
// TODO: Create databse reference for Coursel Slider to take value intput from storage
// TODO: Signup button for narrow screen

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var obscureText = true;
  bool loading = false;
  String email = "";
  String password = "";
  String repeat = "";

  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool pwd = false;
  bool isNewUser = false;
  User? user;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    password = passController.value.text;
    email = emailController.value.text;

    setState(() {
      loading = true;
    });

    final User? user = await Auth().signInWithEmailAndPassword(email, password);

    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Home()));
    }
    setState(() {
      loading = false;
    });
  }

  void handleSignup() async {
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
      }

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Onboarding()));
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

  updatePwd() {
    setState(() {
      pwd = true;
      isNewUser = false;
    });
  }

  updateNew() {
    setState(() {
      pwd = true;
      isNewUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return DesktopLayout(
          constraints: constraints,
          emailController: emailController,
          passController: passController,
          confPassController: confPassController,
          formKey: formKey,
          pwd: pwd,
          handleLogin: handleLogin,
          handleSignup: handleSignup,
          updatePwd: updatePwd,
          updateNew: updateNew,
          loading: loading,
          isMobile: true,
          isNewUser: isNewUser,
        );
      } else {
        return DesktopLayout(
          constraints: constraints,
          emailController: emailController,
          passController: passController,
          confPassController: confPassController,
          formKey: formKey,
          pwd: pwd,
          handleLogin: handleLogin,
          handleSignup: handleSignup,
          updatePwd: updatePwd,
          updateNew: updateNew,
          loading: loading,
          isMobile: false,
          isNewUser: isNewUser,
        );
      }
    });
  }
}

// ---------------------------------------------------------------------------------------
// Desktop Layout
// ---------------------------------------------------------------------------------------

class DesktopLayout extends StatefulWidget {
  final BoxConstraints constraints;
  final TextEditingController emailController,
      passController,
      confPassController;
  final GlobalKey<FormState> formKey;
  final bool pwd, loading, isMobile, isNewUser;
  final Function() handleLogin;
  final Function() handleSignup;
  final Function() updatePwd;
  final Function() updateNew;

  const DesktopLayout({
    super.key,
    required this.constraints,
    required this.emailController,
    required this.passController,
    required this.confPassController,
    required this.formKey,
    required this.pwd,
    required this.handleLogin,
    required this.handleSignup,
    required this.updatePwd,
    required this.updateNew,
    required this.loading,
    required this.isMobile,
    required this.isNewUser,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container For Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xddffffff), Color(0xdd1f3e3c)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Row(
            children: [
              // First Colm
              Visibility(
                visible: !widget.isMobile,
                child: Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Learners' Club
                      SizedBox(
                        width: widget.constraints.maxWidth / 3,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Learners’ \nClub',
                            style: GoogleFonts.unbounded(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 70,
                                  color: Color(0xff1F3E3C)),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // Learning Unbounded
                      Container(
                        width: widget.constraints.maxWidth / 3,
                        padding: EdgeInsets.fromLTRB(
                            0, 5, widget.constraints.maxWidth * .1, 5),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Learning Unbounded',
                            style: GoogleFonts.unbounded(
                              textStyle: const TextStyle(
                                  fontFamily: 'Unbounded',
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0x991F3E3C)),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      // Scrolling reviews
                      Container(
                        width: widget.constraints.maxWidth / 3,
                        height: widget.constraints.maxHeight / 3,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0x80F7F7F7),
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 500,
                            // aspectRatio: 16/9,
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: <Widget>[
                            Reviews(
                              name: 'ABZ Unlimited',
                              imgURL: "assets/ABZ.jpg",
                              rev:
                                  'Learners’ Club is a wonderful place to learn and improve our understanding of concepts. The mentors are very skilled, helping and provide us with a lot of value. I can’t thank Learners’ Club enough',
                              constraints: widget.constraints,
                            ),
                            Reviews(
                              name: 'ABZ',
                              imgURL: "assets/ABZ.jpg",
                              rev:
                                  'Learners’ Club is a wonderful place to learn and improve our understanding of concepts. The mentors are very skilled, helping and provide us with a lot of value. I can’t thank Learners’ Club enough',
                              constraints: widget.constraints,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Secoond Colm
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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

                              Visibility(
                                visible: widget.isMobile,
                                child: const SizedBox(
                                  height: 5,
                                ),
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

                              Visibility(
                                visible: widget.isMobile,
                                child: const SizedBox(
                                  height: 35,
                                ),
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
                                vertical: 40, horizontal: 30),
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
                                    widget.isNewUser ? "Signup" : "Login",
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

                                  Visibility(
                                    visible: widget.isNewUser,
                                    child: Text(
                                      "Create an Account",
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                          color: Color(0xff1F3E3C),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                    visible: widget.isNewUser,
                                    child: Text(
                                      "Seems like you do not have an account",
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          color: Color(0xff1F3E3C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                    visible: widget.isNewUser,
                                    child: const SizedBox(
                                      height: 20,
                                    ),
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
                                  Visibility(
                                    visible: widget.pwd,
                                    child: FormInput(
                                      textController: widget.passController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      label: 'Password',
                                      hint: 'Enter your password',
                                      obsTxt: true,
                                      vis: widget.pwd,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // Confirm Password
                                  Visibility(
                                    visible: widget.isNewUser,
                                    child: FormInput(
                                      textController: widget.passController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      label: 'Confirm Password',
                                      hint: 'Enter your password',
                                      obsTxt: true,
                                      vis: widget.isNewUser,
                                    ),
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
                                    onPressed: () async {
                                      if (!widget.formKey.currentState!.validate()) {
                                        return;
                                      }
                                      else {
                                        if (await Auth().isEmailRegistered(
                                            widget.emailController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Welcome Back'),
                                            ),
                                          );
                                          if (!widget.pwd) {
                                            widget.updatePwd();
                                          } else {
                                            if (widget.isNewUser) {
                                              widget.updatePwd();
                                            } else {
                                              widget.handleLogin();
                                            }
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                              Text('User does not exist'),
                                            ),
                                          );
                                          if (!widget.isNewUser) {
                                            widget.updateNew();
                                          } else {
                                            widget.handleSignup();
                                          }
                                        }
                                      }
                                    },
                                    child: widget.loading
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 23,
                                                width: 23,
                                                child:
                                                    CircularProgressIndicator(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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

                                  const Text('or continue with'),
                                  const SizedBox(height: 15),

                                  // Google
                                  FilledButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              const Color(0xffeeeeee)),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      var user =
                                          await Auth().signInWithGoogle();
                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()));
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/google_logo.png'),
                                              height: 15),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Google',
                                            style: GoogleFonts.archivo(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                            decoration:
                                                TextDecoration.underline,
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
                                              decoration:
                                                  TextDecoration.underline),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
