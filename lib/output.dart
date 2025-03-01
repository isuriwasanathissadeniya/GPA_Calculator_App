import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final double gpa;

  OutputScreen({required this.gpa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Result')),
      body: Center(
        child: Text(
          'Your GPA: ${gpa.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
