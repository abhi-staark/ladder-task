import 'package:flutter/material.dart';

class HistogramBar extends StatelessWidget {
  final int value;
  final Color color;

  const HistogramBar({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: value.toDouble(),
          height: 20,
          color: color,
        ),
        Text(value.toString()),
      ],
    );
  }
}
