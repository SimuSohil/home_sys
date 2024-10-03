import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_manage_sys/views/home_screens/tasks_screens/tasks_details.dart';

class TaskListview extends StatefulWidget {
  final String userId;

  const TaskListview({
    super.key,
    required this.userId,
  });

  @override
  State<TaskListview> createState() => _TaskListviewState();
}

class _TaskListviewState extends State<TaskListview> {
  List<dynamic> tasks = [];

  String _formatDueDate(String dueDate) {
    final inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    final dateTime = inputFormat.parseUTC(dueDate).toLocal();
    final outputFormat = DateFormat('EEE, dd MMM yyyy');
    return outputFormat.format(dateTime);
  }

  final Map<String, Color> priorityColor = {
    'high' : Colors.red,
    'medium' : Colors.orange,
    'low' : Colors.green,
  };

  @override
  void initState(){
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty ? 
    const Center(child: CircularProgressIndicator(),) : 
    ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final priority = task['priority']?.toString().toLowerCase() ?? 'low';
        final color = priorityColor[priority] ?? Colors.grey;
    
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(task['priority'][0].toString().toUpperCase(), style: TextStyle(color: PrimaryColors.primaryColor4),),
          ),
          title: Text(task['task_name'] ?? 'no tasks', style: const TextStyle(fontWeight: FontWeight.w700),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Due Date: ${_formatDueDate(task['due_date'])}')
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TasksDetailsScreen(
                  taskDetails: task,
                  userId: widget.userId
                )
              )
            );
          },
        );
      }
    );
  }

  Future<void> fetchdata() async {
    final url = 'http://127.0.0.1:5000/tasks/${widget.userId}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      setState(() {
        tasks = json.decode(body);
      });
    }
    else {
      throw Exception('failed to fetch data');
    }
  }
}