import 'package:flutter/material.dart';

class PriceSelectionOverlay extends StatelessWidget {
  final String price;
  final VoidCallback onBuy;
  final VoidCallback onSell;

  const PriceSelectionOverlay({
    super.key,
    required this.price,
    required this.onBuy,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: onBuy, child: const Text('Buy STP')),
        Text(price),
        ElevatedButton(onPressed: onSell, child: const Text('Sell STP')),
      ],
    );
  }
}
