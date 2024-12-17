import 'package:flutter/material.dart';
import 'package:tradeapp/src/utils/helper_functions.dart';
import 'package:tradeapp/src/widgets/price_tile.dart';

class PriceLadder extends StatelessWidget {
  // Sample Data for Bids and Asks
  final List<Map<String, String>> bids = [
    {'price': '1001.5', 'quantity': '50'},
    {'price': '1001.0', 'quantity': '70'},
    {'price': '1000.5', 'quantity': '120'},
  ];

  final List<Map<String, String>> asks = [
    {'price': '999.5', 'quantity': '30'},
    {'price': '999.0', 'quantity': '60'},
    {'price': '998.5', 'quantity': '90'},
  ];

  final String ltp = '1000.0'; // Last Traded Price

  PriceLadder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Bids Section (Above LTP)
        ...bids.map(
          (bid) => PriceTile(
            price: bid['price']!,
            quantity: bid['quantity']!,
            color: Colors.green, // Green for bids
            onTap: () {
              showPriceSelectionOverlay(context, bid['price']!);
            },
          ),
        ),

        // LTP (Last Traded Price)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.yellow.shade200,
          child: Center(
            child: Text(
              'LTP: $ltp',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Asks Section (Below LTP)
        ...asks.map(
          (ask) => PriceTile(
            price: ask['price']!,
            quantity: ask['quantity']!,
            color: Colors.red, // Red for asks
            onTap: () {
              showPriceSelectionOverlay(context, ask['price']!);
            },
          ),
        ),
      ],
    );
  }
}
