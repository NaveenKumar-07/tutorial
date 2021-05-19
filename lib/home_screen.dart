import 'package:flutter/material.dart';
import 'package:tutorial/Job.dart';
import 'dart:core';
import 'package:tutorial/JoblistScreen.dart';
import 'package:tutorial/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Jobs",
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
