import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial/JoblistScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:tutorial/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = false;
  final name = TextEditingController();
  final pass = TextEditingController();
  bool islogged;

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    final response = await http.post(
        "https://unmetrical-drawer.000webhostapp.com/login.php",
        body: {"name": name.text, "password": pass.text});

    var message = json.decode(response.body);
    if (message == "Login Successful..") {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => JobListScreen()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else if (message == "Incorrect Username..Try Again") {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else if (message == "Incorrect Password..Try Again") {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }

  Future<void> loggedin() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences logindata = await SharedPreferences.getInstance();
    var email = logindata.getString('email');
    var username = logindata.getString('username');
  }

  Future<void> initState() {
    super.initState();
    loggedin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blueGrey, Colors.lightBlueAccent]),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 100, right: 10.0),
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        fontFamily: "Chanda",
                                        color: Colors.deepPurple,
                                        fontSize: 50,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Column(
                                  children: <Widget>[
                                    Container(height: 60),
                                    Center(
                                      child: Text(
                                        "JOBS 360°",
                                        style: TextStyle(
                                            fontFamily: 'Bangers',
                                            fontSize: 70.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 2.0,
                                            shadows: <Shadow>[
                                              Shadow(
                                                  blurRadius: 15.0,
                                                  color: Colors.white70,
                                                  offset: Offset.fromDirection(
                                                      120, 12))
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 50.0, right: 50.0),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: name,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0))),
                                  fillColor: Colors.lightBlueAccent,
                                  labelText: "Username",
                                  labelStyle: TextStyle(color: Colors.white70)),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 50.0, right: 50.0),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: pass,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0))),
                                    fillColor: Colors.lightBlueAccent,
                                    labelText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.white70)),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 40.0, left: 200.0, right: 50.0),
                            child: Container(
                                alignment: Alignment.bottomRight,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue[300],
                                          blurRadius: 10.0,
                                          spreadRadius: 1.3,
                                          offset: Offset(5.0, 5.0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlatButton(
                                    onPressed: userLogin,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.lightBlueAccent,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )))),
                        Visibility(
                            visible: visible,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                      ],
                    )
                  ],
                ))));
  }
}
