import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_manage_sys/screens/login_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logout() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Management System'), 
        backgroundColor: Colors.brown[300],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage())
            );
          }, 
          icon: const Icon(Icons.logout)
        )
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(opacity: 0.3, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
        ],
      )
    );
  }
}