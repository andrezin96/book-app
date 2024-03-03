import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/tbr/bloc/tbr_bloc.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TbrButton extends StatelessWidget {
  const TbrButton({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SMessenger().menssenger(context, 'Adicionado a TBR!', Colors.green);
        context.read<TbrBloc>().add(TbrAddEvent(book));
      },
      icon: const Icon(
          Icons.bookmark_add_outlined,
          color: Colors.blue),
    );
  }
}