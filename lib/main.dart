import 'package:consumo_api_class/api/api.dart';
import 'package:consumo_api_class/models/post_model.dart';
import 'package:consumo_api_class/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumo de APIs',
      home: HomePage(),
    );
  }
}
