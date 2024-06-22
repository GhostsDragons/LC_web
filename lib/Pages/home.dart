// ignore_for_file: unused_import

import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:lc_web/Functions/sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
const Home({super.key});

@override
Widget build(BuildContext context) {
	return const MaterialApp(
	debugShowCheckedModeBanner: false,
	title: 'Collapse Sidebar',
	home: Scaffold(
		body: Sidebar(),
	),
	);
}
}





