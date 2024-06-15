// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileLayout(constraints: constraints);
        } else {
          return DesktopLayout(constraints: constraints);
        }
      },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              tileColor: Colors.blue,
              // leading: const Icon(Icons.explore),
              title: const Text(
                "Learners' Club",
                style: TextStyle(fontSize: 20),),
              onTap: () => Navigator.pop(context), // Close drawer on tap
            ),

            const SizedBox(height: 10,),

            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: const Text(
                'Discover',
                style: TextStyle(
                  fontSize: 25
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendar'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.bookmarks),
              title: const Text('Course Catalog'),
              onTap: () => Navigator.pop(context),
            ),

            const Divider(height: 20.0, thickness: 1.0), 

            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: const Text(
                'Courses',
                style: TextStyle(
                  fontSize: 25
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.auto_graph_sharp),
              title: const Text('1:1 Mentorship Program'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.lightbulb),
              title: const Text('Concept Clarity'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Copywriting 101'),
              onTap: () => Navigator.pop(context),
            ),

            const Divider(height: 20.0, thickness: 1.0), 

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Your Profile'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}