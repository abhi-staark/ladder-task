import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_colors.dart';
import 'package:tradeapp/src/constants/app_sizes.dart';
import 'package:tradeapp/src/theme/app_theme.dart';
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
          Container(
            height: 36,
            width: 102,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.appBorderRadius),
                border: Border.all(
                  color: AppColor.whiteColor,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    height: 20,
                    width: 30,
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: myTextTheme.bodySmall!
                          .copyWith(fontSize: 12, color: AppColor.whiteColor),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: AppSizes.appPadding),
                          border: UnderlineInputBorder()),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Qty',
                  style: myTextTheme.bodySmall!
                      .copyWith(color: AppColor.whiteColor, fontSize: 12),
                )
              ],
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
