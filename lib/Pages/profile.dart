import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lc_web/Firebase/_storage.dart';
import 'package:lc_web/Functions/widgets.dart';
import 'package:lc_web/Functions/sidebar.dart';
import 'package:lc_web/Firebase/_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final User? user = Auth().getUser();
  late String provider;
  late String? uid;
  late String? profilePhoto;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  bool nameEdit = false;
  static List<String?> links = [null];
  XFile? file;

  Future<void> _pickProfile() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
  }


  @override
  Widget build(BuildContext context) {



    final user = this.user;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.com, etc.)
        provider = providerProfile.providerId;
        // print(user);

        // UID specific to the provider
        uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        nameController.text = providerProfile.displayName!;
        emailController.text = providerProfile.email!;
        profilePhoto = providerProfile.photoURL;
      }
    }

    return Scaffold(
      body: Sidebar(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Your Profile"),
            const SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Stack(
                      children: [CircleAvatar(
                        backgroundImage: NetworkImage(profilePhoto!),
                        radius: 50,
                      ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Color(0xff1F3E3C)),
                            ),
                            icon: const Icon(Icons.mode_edit_outline_outlined),
                            color: Colors.white,
                            onPressed:() async {
                                await _pickProfile();
                                print(file);
                              await Storage().updateProfilePic("temp", file);
                              setState(() {

                              });
                            },
                          ),
                        ),
      ]
                    ),

                const SizedBox(width: 15,),

                // nameEdit?
                Text(
                  nameController.text,
                ),
                    // : FormInput(textController: nameController, keyboardType: TextInputType.name),


              ],
            ),

            const Text('Email'),

            FormInput(textController: emailController, keyboardType: TextInputType.emailAddress),

            const Text('Links'),

          //   TODO: Add dynamic text box

            const Text('Bio'),

            const TextField(
                decoration: InputDecoration(
                  hintText: "Enter your bio"
                ),)

          ],
        ),
      ),

    );
  }
}