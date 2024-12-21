import 'package:flutter/material.dart';
import 'package:tradeapp/src/theme/app_theme.dart';

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
    return Container(
      height: 34,
      decoration: BoxDecoration(
          border: Border.all(color: (Colors.blue)),
          gradient: RadialGradient(
            radius: 0,
            colors: [Colors.blue, Colors.blue.withOpacity(0.5)],
          ),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: onBuy,
              child: Container(
                  height: 34,
                  width: 81,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text('Buy STP',
                        style: myTextTheme.bodySmall!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ))),
          Text(
            price,
            style: myTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.w100),
          ),
          InkWell(
            onTap: onSell,
            child: Container(
                height: 34,
                width: 81,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text('Sell STP',
                      style: myTextTheme.bodySmall!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                )),
          ),
        ],
      ),
    );
  }
}
