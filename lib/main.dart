import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const FrasesApp());
}

class FrasesApp extends StatelessWidget {
  const FrasesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frases Motivadoras SENA',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
