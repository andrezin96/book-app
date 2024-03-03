import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      maxLines: 3,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Comentário...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
