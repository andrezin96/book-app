import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      this.onEditingComplete,
      this.onChanged,
      this.onPressed,
      this.onTap,
      this.autofocus = false,
      this.suffixIcon,
      this.prefixIcon});

  final TextEditingController controller;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintText: 'Pesquisar...',
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
      ),
    );
  }
}
