// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const HttpApp());
}

class HttpApp extends StatelessWidget {
  const HttpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List users = [];
  bool isLoading = true;

  // Function to fetch users
  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body); // Parsing JSON response
      });
    } else {
      print('Failed to load users');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Http Request'),
        ),
        body: users.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  // list tile widget
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.brown[100],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(users[index]['name']),
                            subtitle: Text(users[index]['email'])
                          ),
                          Row(
                            children: [
                              ElevatedButton(onPressed: () {}, child: Icon(Icons.edit)),
                              ElevatedButton(onPressed: () {}, child: Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }));
  }
}
