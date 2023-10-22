import 'package:bloc_test/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( GameOfThrones(approute: AppRoute(),));
}

class GameOfThrones extends StatelessWidget {
   
   final AppRoute approute;
   GameOfThrones({super.key, required this.approute});
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: approute.generateRoute,
      // home: Scaffold(
      //   appBar: AppBar(),
      // ),
    );
  }
}