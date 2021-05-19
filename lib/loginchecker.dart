import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/home_screen.dart';
import 'package:tutorial/login_screen.dart';

class logincheck extends StatefulWidget {
  @override
  _logincheckState createState() => _logincheckState();
}

class _logincheckState extends State<logincheck> {
  @override
  Future<void> initState() {
    super.initState();
    main();
  }

  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences logindata = await SharedPreferences.getInstance();
  var email = logindata.getString('email');
  var username = logindata.getString('username');
  runApp(MaterialApp(home: email == null ? LoginScreen() : HomeScreen()));
}
