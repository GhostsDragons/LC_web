import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Pages/home.dart';
import 'package:lc_web/Pages/signup.dart';
import 'package:lc_web/Functions/functions.dart';

// TODO: Signup with google
// TODO: Link to terms and Services and Privacy Policy
// TODO: Fix the Coursel Slider for narrow screens

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var obscureText = true;
  bool loading = false;
  var email = "";
  var password = "";
  final formKey = GlobalKey<FormState>();
  bool pwd = false;
  User? user;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  Future<void> handleSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    password = passController.value.text;
    email = emailController.value.text;

    setState(() {
      loading = true;
    });

    await Auth().signInWithEmailAndPassword(email, password);

    setState(() {
      loading = false;
    });
  }

  updatePwd() {
    setState(() {
      pwd = !pwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return MobileLayout(
          constraints: constraints,
          emailController: emailController,
          passController: passController,
          formKey: formKey,
          pwd: pwd,
          handleSubmit: handleSubmit,
          updatePwd: updatePwd,
          loading: loading,
        );
      } else {
        return DesktopLayout(
          constraints: constraints,
          emailController: emailController,
          passController: passController,
          formKey: formKey,
          pwd: pwd,
          handleSubmit: handleSubmit,
          updatePwd: updatePwd,
          loading: loading,
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
  final TextEditingController emailController, passController;
  final GlobalKey<FormState> formKey;
  final bool pwd, loading;
  final Function() handleSubmit;
  final Function() updatePwd;

  const DesktopLayout({
    super.key,
    required this.constraints,
    required this.emailController,
    required this.passController,
    required this.formKey,
    required this.pwd,
    required this.handleSubmit,
    required this.updatePwd,
    required this.loading,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  // signIn() async {
  //   await Auth().signInWithGoogle();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const Home()));
  // }

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
              SizedBox(
                width: widget.constraints.maxWidth / 2,
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
                                fontFamily: 'Unbounded',
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

              // Secoond Colm
              Container(
                decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                width: widget.constraints.maxWidth / 3,
                margin:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                child: SingleChildScrollView(
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Login
                        Text(
                          "Login",
                          style: GoogleFonts.unbounded(
                            textStyle: const TextStyle(
                              fontSize: 40,
                              color: Color(0xff1F3E3C),
                              fontWeight: FontWeight.bold,
                              // fontFamily:
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
                        Visibility(
                          visible: widget.pwd,
                          child: FormInput(
                            textController: widget.passController,
                            keyboardType: TextInputType.visiblePassword,
                            label: 'Password',
                            hint: 'Enter your password',
                            obsTxt: true,
                            vis: widget.pwd,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1F3E3C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            if (!widget.pwd) {
                              if (await Auth().isEmailRegistered(
                                  widget.emailController.text)) {
                                widget.updatePwd();
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Signup()));
                              }
                            } else {
                              widget.handleSubmit();
                            }
                          },
                          child: widget.loading
                              ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child:  CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                              : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Sign up with Email',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xffeeeeee)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            var user = await Auth().signInWithGoogle();
                            if(user != null)
                              {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                              }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage('assets/google_logo.png'),
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
  final TextEditingController emailController, passController;
  final GlobalKey<FormState> formKey;
  final bool pwd, loading;
  final Function() handleSubmit;
  final Function() updatePwd;

  const MobileLayout({
    super.key,
    required this.constraints,
    required this.emailController,
    required this.passController,
    required this.formKey,
    required this.pwd,
    required this.handleSubmit,
    required this.updatePwd,
    required this.loading,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      // Background Image
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

      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Learners' Club
              SizedBox(
                width: widget.constraints.maxWidth / 1.5,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Learners’ \nClub',
                    textAlign: TextAlign.center,
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
              SizedBox(
                width: widget.constraints.maxWidth / 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Learning Unbounded',
                    style: GoogleFonts.unbounded(
                      textStyle: const TextStyle(
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

              Container(
                decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Login
                      Text(
                        "Login",
                        style: GoogleFonts.unbounded(
                          textStyle: const TextStyle(
                            fontSize: 40,
                            color: Color(0xff1F3E3C),
                            fontWeight: FontWeight.bold,
                            // fontFamily:
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
                      Visibility(
                        visible: widget.pwd,
                        child: FormInput(
                          textController: widget.passController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          hint: 'Enter password',
                          obsTxt: true,
                          vis: widget.pwd,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1F3E3C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          if (!widget.pwd) {
                            if (await Auth().isEmailRegistered(
                                widget.emailController.text)) {
                              widget.updatePwd();
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Signup()));
                            }
                          } else {
                            widget.handleSubmit();
                          }
                        },
                        child: widget.loading
                            ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:  CircularProgressIndicator(
                                    strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                ),
                              ),
                            )
                            : const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign up with Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
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
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xffeeeeee)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var user = await Auth().signInWithGoogle();
                          if(user != null)
                          {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                  image: AssetImage('assets/google_logo.png'),
                                  height: 15),
                              const SizedBox(
                                width: 10,
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
            ],
          ),
        ),
      )
    ]));
  }
}
