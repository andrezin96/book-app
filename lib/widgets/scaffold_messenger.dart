import 'package:flutter/material.dart';

class SMessenger {
  void menssenger(BuildContext context, String messenge, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messenge),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }
}
