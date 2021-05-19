import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutorial/home_screen.dart';
import 'package:tutorial/loginchecker.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 4), () {});
    return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => logincheck()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/js5.jpg'), fit: BoxFit.fill)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Shimmer.fromColors(
            period: Duration(seconds: 4),
            baseColor: Color(0xff4169E1),
            highlightColor: Color(0xff08B8Bff),
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
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
                              offset: Offset.fromDirection(120, 12))
                        ]),
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
