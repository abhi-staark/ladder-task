import 'package:flutter/material.dart';
import 'package:tradeapp/src/widgets/histogram.dart';

class PriceTile extends StatelessWidget {
  final String price;
  final String quantity;
  final Color color;
  final VoidCallback onTap;

  const PriceTile({
    required this.price,
    required this.quantity,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: color.withOpacity(0.1),
      title: Text(price, style: const TextStyle(fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(quantity, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          HistogramBar(value: int.parse(quantity)),
        ],
      ),
    );
  }
}
