import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreenPage extends StatefulWidget {
  final String userId;

  const HomeScreenPage({super.key, required this.userId});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  List<dynamic> tasks = [];

  final List<String> _quotes = <String>[
    "Family is not an important thing, it's everything.\n— Michael J. Fox",
    "The most important work you will ever do will be within the walls of your own home.\n— Harold B. Lee",
    "Family is the compass that guides us. They are the inspiration to reach great heights, and our comfort when we occasionally falter.\n— Brad Henry",
    "A happy family is but an earlier heaven.\n— George Bernard Shaw"
  ];

  late String _currentQuote = '';
  late Timer _timer;
  final Random _random = Random();

  void _quoteChanger() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        _currentQuote = _quotes[_random.nextInt(_quotes.length)];
      });
    });
  }

  late String greeting = '';

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12){
      greeting = "Good Morning";
    }
    else if (hour < 17){
      greeting = "Good Afternoon";
    }
    else {
      greeting = 'Good Evening';
    }
  }

  final Map<String, Color> _priorityColor = {
    'high' : Colors.red,
    'medium' : Colors.orange,
    'low' : Colors.green,
  };

  String _formatDueDate(String dueDate) {
  final inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
  final dateTime = inputFormat.parseUTC(dueDate).toLocal();
  final outputFormat = DateFormat('EEE, dd MMM yyyy');
  return outputFormat.format(dateTime);
}

  @override
  void initState(){
    super.initState();
    _currentQuote = _quotes[_random.nextInt(_quotes.length)];
    _quoteChanger();
    _updateGreeting();
    fetchData();
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

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
                    height: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Container(
                                color: Colors.brown[300],
                                child: Image.asset('assets/proj_image.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text(greeting, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 35),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          _currentQuote, 
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                        )
                      ],
                    )
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Tasks', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.brown[200]
                    ),
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index){
                        final task = tasks[index];
                        final priority = task['priority']?.toString().toLowerCase() ?? 'low';
                        final color = _priorityColor[priority] ?? Colors.grey;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: color,
                              child: Text(task['priority'][0].toString().toUpperCase()),
                            ),
                            title: Text(task['task_name'] ?? 'no tasks', style: const TextStyle(fontWeight: FontWeight.w700),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Due Date: ${_formatDueDate(task['due_date'])}')
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    final url = 'http://127.0.0.1:5001/tasks/${widget.userId}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      setState(() {
        tasks = json.decode(body);
        print('tasks: $tasks');
      });
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }
}