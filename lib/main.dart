import 'package:flutter/material.dart';
import 'package:test/screens/home_screen.dart';
import 'package:test/screens/post_detail_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: HomeScreen(),
    routes: {
      '/home': (context) => HomeScreen(),
      '/post-detail': (context) => PostDetailScreen(),
    },
  ));
}
