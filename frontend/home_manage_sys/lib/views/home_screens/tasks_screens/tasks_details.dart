import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class TasksDetailsScreen extends StatefulWidget {
  final String userId;

  const TasksDetailsScreen({super.key, required this.userId});

  @override
  State<TasksDetailsScreen> createState() => _TasksDetailsScreenState();
}

class _TasksDetailsScreenState extends State<TasksDetailsScreen> {
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
        backgroundColor: PrimaryColors.primaryColor1,
      ),
    );
  }
}