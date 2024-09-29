import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';
import 'package:home_manage_sys/views/home_screens/tasks_screens/task_listview.dart';

class TasksPage extends StatefulWidget {
  final String userId;

  const TasksPage({super.key, required this.userId});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(opacity: 0.3, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
            SingleChildScrollView(
              child: Column(
                children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width, 
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tasks', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),),
                              ElevatedButton.icon(
                                onPressed: () {}, 
                                icon: const Icon(Icons.add),
                                label: Text('Add Tasks', style: TextStyle(color: PrimaryColors.primaryColor2),),
                                style: ElevatedButton.styleFrom(
                                  iconColor: PrimaryColors.primaryColor2,
                                  backgroundColor: PrimaryColors.primaryColor1
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 550,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.brown[200]?.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TaskListview(userId: widget.userId)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}