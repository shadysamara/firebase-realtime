import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_todo/todo_app_realtime.dart';
import 'package:login_firebase/firebase_todo_home.dart';
import 'package:login_firebase/login_controller.dart';

import 'package:login_firebase/ui/screens/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TodoHomePage(),
    );
  }
}
