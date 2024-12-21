import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/pages/ladder_page.dart';
import 'package:tradeapp/src/theme/app_theme.dart';
import 'package:tradeapp/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: LadderPage());
  }
}
