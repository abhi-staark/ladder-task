import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onBuy;
  final VoidCallback onSell;
  final TextEditingController quantityController;

  const ActionButtons({
    super.key,
    required this.onBuy,
    required this.onSell,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(onPressed: onBuy, child: Text('Buy MKT')),
        SizedBox(
          width: 50,
          child: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        ElevatedButton(onPressed: onSell, child: Text('Sell MKT')),
      ],
    );
  }
}
