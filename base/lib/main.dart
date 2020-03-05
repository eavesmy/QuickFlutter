import 'package:flutter/material.dart';
import './init.dart';

void main() async {
	init()
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
	  home: Container()
    );
  }
}
