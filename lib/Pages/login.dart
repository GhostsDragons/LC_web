import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Firebase/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _layoutBuilderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text("Hi");
        } 
        else {
          return LayoutBuilder(
            key: _layoutBuilderKey,
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return MobileLayout(constraints: constraints);
              } 
              else {
                return DesktopLayout(constraints: constraints);
              }
            }
          );
        }
      }
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
  int maxWidth = 250;
  int maxHeight = 50;

  var obscureText = true;
  bool loading = false;
  var email = "";
  var password = "";
  final formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  handleSubmit() async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    password = passwordcontroller.value.text;
    email = emailcontroller.value.text;

    setState(() {
      loading = true;
    });

    await Auth().signInWithEmailAndPassword(email, password);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BG.jpg'),
            fit: BoxFit.cover,
            opacity: .5,
          ),

          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xff67D0C8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(05, 5, 30, 5),
              width: widget.constraints.maxWidth / 2,
              alignment: Alignment.center,
              color: const Color.fromRGBO(255, 0, 0, 1),
              child: const Text(
                "Here",
                style: TextStyle(fontSize: 24),
              ),
            ),

            Container(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              padding: const EdgeInsets.fromLTRB(25, 75, 25, 75),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFFBDE3EA)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          width: 250,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: AssetImage('assets/R.png'),
                                height: 25
                              ),

                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Archivo",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Gap between Sign in with Google and alternative
                      // ---------------------------------------------------------------------------------------

                      const SizedBox(
                        height: 20,
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Or Line
                      // ---------------------------------------------------------------------------------------

                      SizedBox(
                        width: 158,
                        height: 30,
                        child: Stack(
                          children: [
                            const Positioned(
                              left: 69,
                              top: 0,
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // ---------------------------------------------------------------------------------------
                            // Left line to 'Or'
                            // ---------------------------------------------------------------------------------------

                            Positioned(
                              left: 60,
                              top: 15,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-3.14),
                                child: Container(
                                  width: 60,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.50,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // ---------------------------------------------------------------------------------------
                            // Right Line to 'Or'
                            // ---------------------------------------------------------------------------------------

                            Positioned(
                              left: 158,
                              top: 15,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-3.14),
                                child: Container(
                                  width: 60,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.50,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Email Input
                      // ---------------------------------------------------------------------------------------

                      Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email ID',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Archivo",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Password Input
                      // ---------------------------------------------------------------------------------------

                      Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          controller: passwordcontroller,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Archivo",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Forgot Password
                      // ---------------------------------------------------------------------------------------

                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: Color(0xFF6A7A81),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Gap between Forgot Password and Login button
                      // ---------------------------------------------------------------------------------------

                      const SizedBox(
                        height: 25,
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Login Button
                      // ---------------------------------------------------------------------------------------

                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xFF55B4E0)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () => handleSubmit(),
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ),
                      ),

                      // ---------------------------------------------------------------------------------------
                      // Gap between button and New User? Sign Up
                      // ---------------------------------------------------------------------------------------

                      const SizedBox(
                        height: 15,
                      ),

                      // ---------------------------------------------------------------------------------------
                      // New User? Sign Up
                      // ---------------------------------------------------------------------------------------

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'New User? Sign Up',
                          style: TextStyle(
                            color: Color(0xFF4C5357),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
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
      ),
    );
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
  int maxWidth = 250;
  int maxHeight = 50;

  var obscureText = true;
  bool loading = false;
  var email = "";
  var password = "";
  final formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  handleSubmit() async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    password = passwordcontroller.value.text;
    email = emailcontroller.value.text;

    setState(() {
      loading = true;
    });

    await Auth().signInWithEmailAndPassword(email, password);

    setState(() {
      loading = false;
    });
  }

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
                opacity: .5,
              ),

              color: Color.fromRGBO(0, 0, 0, 0.9),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff67D0C8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),


        ]
      )
    );
  }
}


