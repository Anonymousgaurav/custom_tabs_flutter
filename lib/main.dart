import 'package:custom_tab_flutter/tab_bar_1.dart';
import 'package:custom_tab_flutter/tab_bar_2.dart';
import 'package:custom_tab_flutter/tab_bar_3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SafeArea(child: Material(child: CustomTabBarsPage(),))
    );
  }
}
