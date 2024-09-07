import 'package:flutter/material.dart';

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(opacity: 0.3, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
          SingleChildScrollView(
            child: Column(
              children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, 
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Container(
                                color: Colors.brown[300],
                                child: Image.asset('assets/proj_image2.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Text('Family Tasks', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),),
                          ],
                        ),
                      ],
                    )
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 550,
                      decoration: BoxDecoration(
                        color: Colors.brown[200],
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Future<void> fetchTaskData() async {
    final url = 'http://127.0.0.1:5000/tasks/${widget.userId}';
  }
}