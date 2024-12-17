import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_sizes.dart';
import 'package:tradeapp/src/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color buttonColor;
  final double buttonHeight;
  final double buttonWidth;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonColor = Colors.blue,
    required this.buttonHeight,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(AppSizes.appBorderRadius),
        ),
        child: Center(
          child: Text(text,
              style: myTextTheme.bodySmall!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
