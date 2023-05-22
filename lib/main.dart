import 'package:flutter/material.dart';
import 'package:network_tools/screens/home.dart';
import 'package:network_tools/screens/tabs.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp() ,
        debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs(),
    );
  }
}
