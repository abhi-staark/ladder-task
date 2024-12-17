import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_colors.dart';
import 'package:tradeapp/src/constants/app_sizes.dart';
import 'package:tradeapp/src/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String stockName;
  final String dayPnl;
  final int pendingOrders;
  final VoidCallback onBack;

  const CustomAppBar({
    super.key,
    required this.stockName,
    required this.dayPnl,
    required this.pendingOrders,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.whiteColor,
                  ),
                  onPressed: onBack),
              Column(
                children: [
                  Text(stockName,
                      style: myTextTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.whiteColor)),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_up,
                        color: AppColor.greenColor,
                      ),
                      Text("20.25 (% 1.25)",
                          style: myTextTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.greenColor)),
                    ],
                  )
                ],
              ),
              IconButton(
                  icon: const Icon(
                    Icons.tune,
                    color: AppColor.whiteColor,
                  ),
                  onPressed: onBack),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          //row 2
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //column1 - pnl
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dayPnl,
                        style: myTextTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.greenColor)),
                    Text('Day P&L',
                        style: myTextTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),

                //column2 - positions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(dayPnl,
                        style: myTextTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.greenColor)),
                    Text('+1@1234.35',
                        style: myTextTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),

                //column3 - pending orders
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('0',
                        style: myTextTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                    Text('Pending',
                        style: myTextTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
