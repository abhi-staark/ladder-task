import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_ladder.dart';
import 'package:tradeapp/src/widgets/action_buttons.dart';
import 'package:tradeapp/src/widgets/custom_appbar.dart';

class LadderPage extends StatelessWidget {
  final TextEditingController quantityController = TextEditingController();

  LadderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        stockName: "HDFCBANK",
        dayPnl: "+₹2.45",
        pendingOrders: 1,
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: PriceLadder(), // Custom widget for bid/ask ladder
          ),
          ActionButtons(
            onBuy: () {},
            onSell: () {},
            quantityController: quantityController,
          ),
        ],
      ),
    );
  }
}
