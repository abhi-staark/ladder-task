// Helper Function to Show Overlay on Price Selection
import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_selection_overlay.dart';

void showPriceSelectionOverlay(BuildContext context, String price) {
  showModalBottomSheet(
    context: context,
    builder: (context) => PriceSelectionOverlay(
      price: price,
      onBuy: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Buy order placed for $price')),
        );
      },
      onSell: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sell order placed for $price')),
        );
      },
    ),
  );
}
