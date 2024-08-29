import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:home_manage_sys/screens/home_page.dart';
import 'package:home_manage_sys/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; 

  String _email = '';
  String _password = '';

  void login() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    log('email: $_email');
    log('password: $_password');

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      log('login successful: ${userCredential.user?.email}');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }
    catch (e){
      log('error: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login failed: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(title: const Text('Home Management System'), backgroundColor: Colors.brown[300],),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(opacity: 0.3, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        'Login Page',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        filled: true,
                        fillColor: Color(0xffffebd5)
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: const Color(0xffffebd5),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !_isPasswordVisible, 
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffA28B55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            )
                          ),
                          child: const Text('Login', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xffFFFFFF)),),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const SignupPage())
                          );
                        },
                        child: const Text("Not a user? Register Here", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.brown, fontSize: 13),)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}