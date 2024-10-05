import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lc_web/Firebase/_auth.dart';
import 'package:lc_web/Firebase/_storage.dart';
import 'package:lc_web/Functions/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = Auth().getUser(); // Current Firebase Auth user
  late String provider;
  late String? uid;
  late String? profilePhoto;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  bool nameEdit = false;
  List<String> data = ["", "", ""]; // Dynamic widgets data (links)
  XFile? file;

  @override
  void initState() {
    super.initState();

    if (user != null) {
      for (final providerProfile in user!.providerData) {
        provider = providerProfile.providerId;
        uid = providerProfile.uid;
        nameController.text = providerProfile.displayName ?? '';
        emailController.text = providerProfile.email ?? '';
        profilePhoto = providerProfile.photoURL;
      }
    } else {
      // Handle null user case (e.g., show error or redirect to login)
    }

    _initializeDynamicWidgets(); // Ensure at least 3 fields for dynamic widgets
    getDataFromFirestore(); // Fetch user data from Firestore
  }

  // Fetch user data from Firestore
  void getDataFromFirestore() async {
    try {
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          var userData = userDoc.data();
          setState(() {
            data = List<String>.from(userData!['links']); // Load user's links
            _initializeDynamicWidgets(); // Ensure at least 3 fields
            bioController.text = userData['bio'] ?? ''; // Load bio if exists
          });
        }
      }
    } catch (e) {
      // Handle errors (like missing document, permissions issues)
      print("Error fetching user data: $e");
    }
  }

  // Initialize dynamic widgets with at least 3 fields
  void _initializeDynamicWidgets() {
    if (data.length < 3) {
      for (int i = data.length; i < 3; i++) {
        data.add("");
      }
    }
  }

  // Add a new dynamic widget
  void addDynamic() {
    setState(() {
      data.add(""); // Add empty link field
    });
  }

  // Delete a dynamic widget
  void _deleteDynamic(int index) {
    setState(() {
      if (data.length > 3) {
        data.removeAt(index); // Remove only if more than 3 exist
      } else {
        data.removeAt(index); // Keep at least 3, clear field instead
        data.add("");
      }
    });
  }

  // Submit user data and update Firestore
  Future<void> submit() async {
    if (user != null) {
      try {
        if (nameController.text != user!.displayName) {
          await user!.updateDisplayName(
              nameController.text); // Update Auth profile name
        }

        if (file != null) {
          // Update profile picture if user picked a new one
          profilePhoto =
              await Storage().updateProfilePic("userProfilePictures", file);
          await user!.updatePhotoURL(profilePhoto); // Update Auth profile photo
        }

        // Update user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'username': nameController.text,
          'email': emailController.text,
          'links': data,
          'profilePictureURL': profilePhoto,
          'bio': bioController.text,
        }, SetOptions(merge: true)); // Merge with existing data

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Profile updated successfully!"),
        ));
      } catch (e) {
        // Handle errors (like permission or network issues)
        print("Error updating profile: $e");
      }
    }
  }

  Future<void> _pickProfile() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);

    // Only proceed if the user picked an image
    if (file != null) {
      setState(() {
        profilePhoto = file!.path; // Temporarily show selected image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Column(
      children: List.generate(data.length, (index) {
        return DynamicWidget(
          key: ValueKey(index),
          controller: TextEditingController(text: data[index]), // Preserve text
          onChanged: (newText) {
            data[index] = newText; // Update list when text changes
          },
          onDelete: () => _deleteDynamic(index),
        );
      }),
    );

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .075,
              horizontal: 10),
          width: (MediaQuery.of(context).size.width < 800)
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: GoogleFonts.archivo(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F3E3C),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: profilePhoto != null
                            ? NetworkImage(profilePhoto!)
                            : null,
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF1F3E3C),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.mode_edit_outline_outlined),
                            color: Colors.white,
                            onPressed: () async {
                              await _pickProfile();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Visibility(
                    visible: !nameEdit,
                    child: Text(
                      nameController.text,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Visibility(
                    visible: nameEdit,
                    child: Expanded(
                      child: FormInput(
                        textController: nameController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: const Icon(Icons.mode_edit_outline_outlined),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        nameEdit = !nameEdit;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Email',
                style: GoogleFonts.archivo(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F3E3C),
                ),
              ),
              FormInput(
                textController: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              Text(
                'Links',
                style: GoogleFonts.archivo(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F3E3C),
                ),
              ),
              dynamicTextField,
              IconButton(
                onPressed: addDynamic,
                icon: const Icon(Icons.add_circle_outline),
              ),
              const SizedBox(height: 20),
              Text(
                'Bio',
                style: GoogleFonts.archivo(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F3E3C),
                ),
              ),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(hintText: "Enter your bio"),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    nameEdit = false;
                  });
                  submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F3E3C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dynamic widget with a delete button for user links
class DynamicWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;

  const DynamicWidget({
    required this.controller,
    required this.onDelete,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(hintText: 'Enter link'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
