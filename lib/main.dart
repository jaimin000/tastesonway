import 'package:flutter/material.dart';
import './screens/dashboard.dart';
import './screens/createtextmenu1.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new CreateTextMenu1(),
    );
  }
}

