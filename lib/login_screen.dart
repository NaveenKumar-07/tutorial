import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:tutorial/login1.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visible = false;
  final email = TextEditingController();
  final name = TextEditingController();
  final pass = TextEditingController();
  SharedPreferences logindata;
  bool newuser;

  Future userRegister() async {
    setState(() {
      visible = true;
    });

    final response = await http.post(
        "https://unmetrical-drawer.000webhostapp.com/register.php",
        body: {"email": email.text, "name": name.text, "password": pass.text});

    var message = json.decode(response.body);
    if (message == "Registered Successfully..") {
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
    } else if (message ==
        "Email Already Exist. Please Try Again With Different Email Address..!!") {
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
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    } else if (message ==
        "Username Already Taken. Please Try Again With Different Username..!!") {
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
                          builder: (BuildContext context) => LoginScreen()));
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
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    child: Text("OK"))
              ],
            );
          });
    }
  }

  Future<void> loginuser() async {
    logindata = await SharedPreferences.getInstance();
    logindata.setString('username', name.text);
    logindata.setString('email', email.text);
  }

  @override
  Future<void> initState() {
    super.initState();
    loginuser();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            body: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/lg1.jpg'),
                        fit: BoxFit.fill)),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 70, 120, 10),
                      child: Text(
                        "Sign Up To Continue.....",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 40.0,
                            color: Colors.black87,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        width: 600,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(20, 10, 60, 0),
                        child: Center(
                            child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0))),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email ID",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ))),
                    Container(
                        width: 600,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(20, 10, 60, 0),
                        child: Center(
                            child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0))),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ))),
                    Container(
                        width: 600,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(20, 10, 60, 0),
                        child: Center(
                            child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0))),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ))),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 25, 70, 10),
                      child: RaisedButton(
                          onPressed: userRegister,
                          elevation: 30.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:
                                  BorderSide(color: Colors.black, width: 0.7)),
                          color: Colors.red,
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 70, 20),
                      child: Text("━━━━━OR━━━━━",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 70, 60),
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          },
                          elevation: 30.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Colors.deepPurpleAccent, width: 0.7)),
                          color: Colors.blueAccent,
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                          )),
                    ),
                    Visibility(
                        visible: visible,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                  ],
                )))));
  }
}
