import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey _layoutBuilderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text('Hi');
          } else {
            return LayoutBuilder(
              key: _layoutBuilderKey,
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return MobileLayout(constraints: constraints);
                } else {
                  return DesktopLayout(constraints: constraints);
                }
              },
            );
          }
        });
  }
}

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
                opacity: 0.5,
              ),

              color: Color.fromRGBO(0, 0, 0, 0.9),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff67D0C8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Center(
            child: Column(
              children: [
                Container(
                  color: Colors.white54,
                
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                
                  width: 600,
                  height: 400,
                
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // fontFamily:
                          ),
                        ),
                
                        const SizedBox(
                          height: 10,
                        ),
                
                        const Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            // fontFamily:
                          ),
                        ),
                
                        // const SizedBox(
                        //   height: 5,
                        // ),
                
                        const Text(
                          "Seems like you do not have an account",
                          style: TextStyle(
                            fontSize: 15,
                            // fontFamily:
                          ),
                        ),
                
                        const SizedBox(
                          height: 20,
                        ),
                  
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'email@domain.com',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),
                
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                        ),
                  
                        const SizedBox(
                          height: 10,
                        ),
                        
                        TextFormField(
                          controller: pass1Controller,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),
                
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                  
                        TextFormField(
                          controller: pass1Controller,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),
                            
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            if (value == null || value.isEmpty || value != pass1Controller.value) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                
                        const SizedBox(
                          height: 10,
                        ),
                
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                
                        const SizedBox(
                          height: 15,
                        ),
                
                        RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'By clicking submit, you agree to our ',
                              style: TextStyle(
                                color: Color(0xFF828282),
                              ),
                            ),
                
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: Color(0xFF1F3E3C),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Color(0xFF828282),
                              ),
                            ),
                
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF1F3E3C),
                                decoration: TextDecoration.underline
                              ),
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
          )
        ],
      )
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
                opacity: 0.5,
              ),

              color: Color.fromRGBO(0, 0, 0, 0.9),
              gradient: LinearGradient(
                colors: [Color(0xffffffff), Color(0xff67D0C8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),

                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.black,
                  //   ),
                  // ),

                  child: const Column(
                    children: [
                      Text(
                        "Learners' Club",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                          // fontFamily:
                        ),
                      ),

                      Text(
                        "Learning Unbounded",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          // fontFamily:
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color: Colors.white54,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),

                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // fontFamily:
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            // fontFamily:
                          ),
                        ),

                        // const SizedBox(
                        //   height: 5,
                        // ),

                        const Text(
                          "Seems like you do not have an account",
                          style: TextStyle(
                            fontSize: 15,
                            // fontFamily:
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                  
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'email@domain.com',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                        ),
                  
                        const SizedBox(
                          height: 10,
                        ),
                        
                        TextFormField(
                          controller: pass1Controller,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                  
                        TextFormField(
                          controller: pass1Controller,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                ),
                              ),
                            ),
                            
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            if (value == null || value.isEmpty || value != pass1Controller.value) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'By clicking submit, you agree to our ',
                              style: TextStyle(
                                color: Color(0xFF828282),
                              ),
                            ),

                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: Color(0xFF1F3E3C),
                                decoration: TextDecoration.underline,
                              ),
                            ),

                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Color(0xFF828282),
                              ),
                            ),

                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF1F3E3C),
                                decoration: TextDecoration.underline
                              ),
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
        ],
      ),
    );
  }
}
