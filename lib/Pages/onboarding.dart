import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:lc_web/Functions/widgets.dart';
import 'package:lc_web/Pages/transition_page.dart';
import 'package:lottie/lottie.dart';
import 'package:lc_web/Firebase/_storage.dart';

// TODO: Use StreamBuilder and try

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return MobileLayout(constraints: constraints);
      } else {
        return DesktopLayout(constraints: constraints);
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
  final User? user = Auth().getUser();

  String? name;
  String? _grade;
  String? _board;

  final List<String> boardOptions = ['CBSE', 'ICSE', 'IGCSE', 'SSC'];
  final List<String> gradeOptions = [
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12'
  ];

  final nameController = TextEditingController();

  XFile? file;

  Future<void> _pickProfile() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  void submit() async {
    name = nameController.text;
    user!.updateDisplayName(name);
    await Storage().updateProfilePic("userProfilePictures", file);
    await Storage().updateDatabase('users', {
      'username': name,
      'grade': _grade,
      'board': _board,
    });

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TransitionPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3E3C),
      body: Row(
        children: [

          // ---------------------------------------------------------------------------------------
          // Left hand side
          // ---------------------------------------------------------------------------------------

          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                width: widget.constraints.maxWidth / 3.5,
                height: widget.constraints.maxHeight / 1.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Tell us a bit more\nabout yourself',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1F3E3C),
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40.0),

                      const Text('Your full name'),

                      const SizedBox(height: 10.0),

                      FormInput(
                        textController: nameController,
                        keyboardType: TextInputType.name,
                        hint: 'Full Name',
                      ),

                      const SizedBox(height: 20.0),

                      Text(
                        'Your grade',
                        style: GoogleFonts.inter(),
                      ),

                      const SizedBox(height: 10.0),

                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: _gradeDropDown(underline: Container())),

                      const SizedBox(height: 20.0),

                      const Text('Your board'),

                      const SizedBox(height: 10.0),

                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: _boardDropDown(underline: Container())),

                      const SizedBox(height: 10.0),

                      // TODO: Setup image picker according to layout
                      Center(
                        child: ElevatedButton(
                          onPressed: _pickProfile,
                          child: const Text('Pick an image'),
                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            submit();
                          },
                          child: const Text('Next'),
                        ),
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

          Visibility(
            visible: true,
            child: Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Lottie.network(
                        'https://lottie.host/75cc02d9-7347-4f47-8814-32d027651e77/M8HI0ZNtCO.json',
                        fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------------------
  // Grade Drop Down
  // ---------------------------------------------------------------------------------------

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
          isExpanded: true,
          isDense: true,
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

  // ---------------------------------------------------------------------------------------
  // Board Drop Down
  // ---------------------------------------------------------------------------------------

  Widget _boardDropDown({
    Widget? underline,
    Widget? icon,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
          value: _board,
          underline: underline,
          icon: icon,
          dropdownColor: dropdownColor,
          style: const TextStyle(fontSize: 15),
          iconEnabledColor: iconEnabledColor,
          isExpanded: true,
          isDense: true,
          onChanged: (String? newValue) {
            setState(() {
              _board = newValue;
            });
          },
          hint: const Text(
            "Select your board",
            style: TextStyle(fontSize: 15),
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
