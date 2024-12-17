import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/bottom_bar.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_ladder.dart';
import 'package:tradeapp/src/widgets/custom_appbar.dart';

class LadderPage extends StatelessWidget {
  final TextEditingController quantityController =
      TextEditingController(text: '1');

  LadderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
            stockName: "HDFCBANK",
            dayPnl: "+₹2.45",
            pendingOrders: 1,
            onBack: () => Navigator.pop(context),
          ),
          body: PriceLadder(),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BottomBar(
                onBuy: () {},
                onSell: () {},
                quantityController: quantityController,
              ))),
    );
  }
}
