import 'package:book_app/models/book/book.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:flutter/material.dart';

class ReadButton extends StatelessWidget {
  const ReadButton({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => ModalSheet().addReadBottomSheet(context, book),
      icon: const Icon(Icons.bookmark_added_outlined, color: Colors.green),
    );
  }
}
