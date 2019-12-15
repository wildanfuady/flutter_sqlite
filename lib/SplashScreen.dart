import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sekolahku_sqlite/ListStudent.dart';
import 'package:sekolahku_sqlite/Login.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{

  void initState(){
    super.initState();
    startSplashScreen();
  }

  startSplashScreen () async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.school,
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(height: 24.0),
            Text(
              "SEKOLAHKU",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}