import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingScreenConstants.onboardingColor2,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/onboard_images/onboard_image2.png'),
              const Text(
                'Smart Reminders and Insights',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Never miss a task again with smart reminders and daily insights. Stay ahead of your household needs, and enjoy peace of mind with automatic updates.',
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