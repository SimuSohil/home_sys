// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';
import 'package:home_manage_sys/views/authentication/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5), 
      () {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const LoginPage())
        );
      }
    );

    return Scaffold(
      backgroundColor: PrimaryColors.primaryColor1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 15,
                    offset: const Offset(2, 2),
                  )
                ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/native_logo.jpeg',
                  width: 100, 
                  height: 100,
                  fit: BoxFit.cover,
                )
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Home Management App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}