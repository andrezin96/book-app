import 'package:book_app/models/book/book.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.book, required this.onPressed});

  final Book book;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.star_border, color: Colors.yellow.shade600),
    );
  }
}