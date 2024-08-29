import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

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

  @override
  void initState(){
    super.initState();
    _currentQuote = _quotes[_random.nextInt(_quotes.length)];
    _quoteChanger();
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width, 
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Good Morning', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),),
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
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.brown[200]
                  ),
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index){
                      final task = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown,
                            child: Text(
                              task['id'].toString(), 
                              style: const TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 20
                              ),
                            ),
                          ),
                          title: Text(task['task'], style: const TextStyle(fontWeight: FontWeight.w700),),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    const url = 'http://127.0.0.1:5000/data';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      setState(() {
        tasks = json.decode(body);
      });
    }
    else {
      throw Exception('Failed to fetch data');
    }
  }
}