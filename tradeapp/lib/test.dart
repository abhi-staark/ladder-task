import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Facing right
            children: [
              Container(
                width: 100,
                height: 50,
                color: Colors.blue,
              ),
              Text("data")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Facing left
            children: [
              Text("data"),
              Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
