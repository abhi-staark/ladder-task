import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_colors.dart';
import 'package:tradeapp/src/widgets/custom_button.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onBuy;
  final VoidCallback onSell;

  final TextEditingController quantityController;

  const BottomBar({
    super.key,
    required this.onBuy,
    required this.onSell,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.blackColor,
      height: 74,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
              buttonHeight: 34,
              buttonWidth: 100,
              onTap: onBuy,
              text: 'Buy MKT',
              buttonColor: AppColor.greenColor),
          SizedBox(
            height: 36,
            width: 102,
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          CustomButton(
              buttonHeight: 34,
              buttonWidth: 100,
              onTap: onSell,
              text: 'Sell MKT',
              buttonColor: AppColor.redColor),
        ],
      ),
    );
  }
}
