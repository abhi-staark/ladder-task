import 'package:flutter/material.dart';
import 'package:tradeapp/src/theme/app_theme.dart';

class HistogramBar extends StatelessWidget {
  final int value;
  final Color color;
  final bool isAsk;

  const HistogramBar({
    super.key,
    required this.value,
    required this.color,
    required this.isAsk,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = myTextTheme.bodySmall!.copyWith(
      color: color,
      fontWeight: FontWeight.w400,
    );

    return Row(
      children: [
        if (!isAsk)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(value.toString(), style: textStyle),
          ),
        Container(
          width: (value / 2).toDouble(),
          height: 31,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        if (isAsk)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(value.toString(), style: textStyle),
          ),
      ],
    );
  }
}
