// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';
import 'package:home_manage_sys/views/home_screens/tasks_screens/task_listview.dart';
import 'package:http/http.dart' as http;

class TaskAddPage extends StatefulWidget {
  final dynamic userId;

  const TaskAddPage({super.key, required this.userId});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  String description = '';
  String assignedTo = '';
  String dueDate = '';
  String priority = 'Medium';
  String status = 'pending';

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dueDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";  // Format as YYYY-MM-DD
      });
    }
  }

  Future<void> submitTask() async {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      final url = 'http://127.0.0.1:8000/add/${widget.userId}';
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type' : 'application/json',
        },
        body: json.encode({
          'task_name': taskName,
          'description': description,
          'assigned_to': assignedTo,
          'due_date': dueDate,
          'priority': priority,
          'status': status,
        })
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully!')),
        );
        Navigator.of(context).pop();
        TaskListview(userId: widget.userId);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add task'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Add Task',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Task Name', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PrimaryColors.primaryColor5
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the Task Name';
                        }
                        return null;
                      },
                      onSaved: (value) => taskName = value!,
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Description', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                        Text('(Optional)', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),)
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PrimaryColors.primaryColor5
                      ),
                      onSaved: (value) => description = value ?? '',
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Assigned To', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PrimaryColors.primaryColor5
                      ),
                      onSaved: (value) => assignedTo = value ?? '',
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Due Date (YYYY-MM-DD)', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: PrimaryColors.primaryColor5,
                          hintText: dueDate.isEmpty ? 'Select Due Date' : dueDate,  // Display the selected date
                        ),
                        child: dueDate.isEmpty 
                          ? const Text('Select Due Date', style: TextStyle(color: Colors.black54))
                          : Text(dueDate, style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Priority', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(filled: true, fillColor: PrimaryColors.primaryColor5),
                      value: priority,
                      items: ['Low', 'Medium', 'High'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          priority = value!;
                        });
                      }, 
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text('Status', style: TextStyle(color: PrimaryColors.primaryColor4, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(filled: true, fillColor: PrimaryColors.primaryColor5),
                      value: status,
                      items: ['pending', 'in progress', 'completed'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      }, 
                    ),
                    const SizedBox(height: 50,),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: submitTask, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColors.primaryColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          )
                        ),
                        child: Text('Submit', style: TextStyle(color: PrimaryColors.primaryColor2),),
                      ),
                    )
                  ],
                ),
              )
            ),
          )
        ],
      )
    );
  }
}