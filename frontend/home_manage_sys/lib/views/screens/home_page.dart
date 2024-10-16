import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_manage_sys/views/authentication/login_page.dart';
import 'package:home_manage_sys/views/home_screens/family_screens/family.dart';
import 'package:home_manage_sys/views/home_screens/home.dart';
import 'package:home_manage_sys/views/home_screens/tasks_screens/tasks_page.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _bottomNavIndex = 0;

  void logout() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetPages = <Widget>[
      HomeScreenPage(userId: widget.userId,),
      TasksPage(userId: widget.userId,),
      FamilyPage()
    ];

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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Family Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
          ],
          backgroundColor: Colors.brown[200],
          selectedItemColor: Colors.brown,
          currentIndex: _bottomNavIndex,
          onTap: (index){
            setState(() {
              _bottomNavIndex = index;
            });
          },
        ),
      ),
      body: widgetPages[_bottomNavIndex]
    );
  }
}