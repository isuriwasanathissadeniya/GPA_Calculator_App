import 'package:flutter/material.dart';
import 'input.dart';
import 'output.dart';

void main() {
  runApp(GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',
      
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InputScreen(),
    );
  }
}
