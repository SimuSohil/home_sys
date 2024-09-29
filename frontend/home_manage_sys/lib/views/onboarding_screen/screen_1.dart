import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingScreenConstants.onboardingColor1,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/onboard_images/onboard_image1.png'),
              const Text(
                'Organize Your Home Effortlessly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Keep your home running smoothly with just a few taps. Manage chores, track tasks, and stay on top of your household like never before, all in one app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}