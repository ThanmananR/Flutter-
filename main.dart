import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(
              color: Colors.blue,   // Change text color
              fontSize: 24,         // Change text size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ),
      ),
    );
  }
}
