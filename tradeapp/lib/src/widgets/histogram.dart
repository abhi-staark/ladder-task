import 'package:flutter/material.dart';

class HistogramBar extends StatelessWidget {
  final int value;

  const HistogramBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: value.toDouble(),
          height: 20,
          color: Colors.greenAccent,
        ),
        Text(value.toString()),
      ],
    );
  }
}
