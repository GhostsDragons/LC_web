import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Firebase/firebase_auth.dart';
import '../Functions/functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
          // Container For Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BG.jpg'),
                fit: BoxFit.cover,
                opacity: .2,
              ),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff1F3E3C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Row(
            children: [
              // First Colm
              SizedBox(
                width: widget.constraints.maxWidth / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Learners' Club
                    SizedBox(
                      width: widget.constraints.maxWidth / 3,
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Learners’ \nClub',
                          style: TextStyle(
                              fontFamily: 'Unbounded',
                              fontWeight: FontWeight.w800,
                              fontSize: 70,
                              color: Color(0xcc1F3E3C)),
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

              // Secoond Colm
              Container(
                decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
                width: widget.constraints.maxWidth / 3,
                margin:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // Login
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // fontFamily:
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // Email ID
                        FormInput(
                          textController: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          hint: 'email@domain.com',
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // Password
                        Visibility(
                          visible: false,
                          child: FormInput(
                            textController: passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'Password',
                            hint: 'Enter your password',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign up with Email',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        const Text('or continue with'),
                        const SizedBox(height: 15),

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
                            width: 291,
                            height: 54,
                            padding: const EdgeInsets.all(10),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                    image: AssetImage('assets/R.png'),
                                    height: 25),
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

                        // Terms and Conditions
                        RichText(
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
            ],
          ),
        ],
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
                opacity: .2,
              ),

              color: Color.fromRGBO(0, 0, 0, 0.9),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff1F3E3C)],
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


