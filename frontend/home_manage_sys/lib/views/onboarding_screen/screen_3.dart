import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingScreenConstants.onboardingColor3,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/onboard_images/onboard_image3.png'),
              const Text(
                'Collaborate with Family',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Invite your family members to stay organized together. Assign tasks, set reminders, and communicate in real-time to keep everyone in sync and on track.',
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