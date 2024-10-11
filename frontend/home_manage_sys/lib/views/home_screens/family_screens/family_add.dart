import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class FamilyAddPage extends StatefulWidget {
  const FamilyAddPage({super.key});

  @override
  State<FamilyAddPage> createState() => _FamilyAddPageState();
}

class _FamilyAddPageState extends State<FamilyAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Management System'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
        backgroundColor: PrimaryColors.primaryColor3,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(opacity: 0.3, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
          
        ],
      ),
    );
  }
}