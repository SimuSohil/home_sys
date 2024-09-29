import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_manage_sys/views/onboarding_screen/screen_3.dart';
import 'package:home_manage_sys/views/screens/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:home_manage_sys/views/onboarding_screen/screen_2.dart';
import 'package:home_manage_sys/views/onboarding_screen/screen_1.dart';


void main() => const OnboardingScreen();

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String buttonText = 'Skip';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              if (index == 2) {
                buttonText = 'Finish';
              }
              else {
                buttonText = 'Skip';
              }
              setState(() {});
            },
            children: const [
              Screen1(),
              Screen2(),
              Screen3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: _pageController, 
                  count: 3
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton.icon(
                    onPressed: _navigateHome, 
                    label: Text(buttonText),
                    icon: const Icon(Icons.arrow_right_alt),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateHome() {
    User? user = _auth.currentUser;
    String userId = user != null ? user.uid : '';

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen(userId: userId))
    );
  }
}