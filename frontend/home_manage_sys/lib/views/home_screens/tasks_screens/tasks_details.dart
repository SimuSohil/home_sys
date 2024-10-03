import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';

class TasksDetailsScreen extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> taskDetails;

  const TasksDetailsScreen({super.key, required this.userId, required this.taskDetails});

  @override
  State<TasksDetailsScreen> createState() => _TasksDetailsScreenState();
}

class _TasksDetailsScreenState extends State<TasksDetailsScreen> {
  late Map<String, dynamic> taskDetails;

  @override
  void initState(){
    super.initState();
    taskDetails = widget.taskDetails;
  }

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 260,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.brown[200]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskDetails['task_name'] ?? 'No Task Name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ), 
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Description: ${taskDetails['description'] ?? 'no description'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Assigned To: ${taskDetails['assigned_to'] ?? 'not assigned'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Priority: ${taskDetails['priority'] ?? 'no priority'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: (taskDetails['priority']?.toString().toLowerCase().trim() == 'high') ? Colors.red : (taskDetails['priority']?.toString().toLowerCase().trim() == 'medium') ? Colors.orange : Colors.green
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Status: ${taskDetails['status']?.toString().toUpperCase() ?? 'No status'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}