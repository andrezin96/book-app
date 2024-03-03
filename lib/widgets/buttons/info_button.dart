import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.info_outline),
    );
  }
}
