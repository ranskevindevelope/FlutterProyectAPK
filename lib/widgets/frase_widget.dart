import 'package:flutter/material.dart';

class FraseWidget extends StatelessWidget {
  final String frase;

  const FraseWidget({super.key, required this.frase});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        frase,
        style: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
