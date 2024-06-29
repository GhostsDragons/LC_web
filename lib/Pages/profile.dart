import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lc_web/Functions/sidebar.dart';
import 'package:lc_web/Firebase/_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final User? user = Auth().getUser();
  late var provider;
  late var uid;
  late String? name, emailAddress, profilePhoto;
  @override
  Widget build(BuildContext context) {
    final user = this.user;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.com, etc.)
        provider = providerProfile.providerId;

        // UID specific to the provider
        uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        name = providerProfile.displayName;
        emailAddress = providerProfile.email;
        profilePhoto = providerProfile.photoURL;
      }
    }

    return Scaffold(
      body: Sidebar(
        body: Column(
          children: [
            const Text("Your Profile"),
            const SizedBox(height: 15,),

            Row(
              children: [
                    CircleAvatar(
                      child: Image.network(profilePhoto!),
                    ),
                  // CircleAvatar(
                  //   child: Icon(Icons.person),
                  // ),

                Column(
                  children: [
                    Text(
                      name!
                    ),
                    // Text('Change Profile Photo')
                  ],
                )
              ],
            )
          ],
        ),
      ),
      
    );
  }
}