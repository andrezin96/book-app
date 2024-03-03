import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:book_app/screens/read/bloc/read_bloc.dart';
import 'package:book_app/widgets/comment_textfield.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFavoriteModalSheet extends StatelessWidget {
  AddFavoriteModalSheet({super.key, required this.book});

  final commentController = TextEditingController();
  final noteController = TextEditingController();
  final Book book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Adicionar Comentário',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: noteController,
                        decoration: const InputDecoration(
                          hintText: 'Nota',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CommentTextField(controller: commentController),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        final note = noteController.text.isEmpty ? 'sem nota' : noteController.text;
                        final comment = commentController.text.isEmpty ? 'sem comentários' : commentController.text;
                        context.read<FavoriteBloc>().add(FavoriteAddEvent(book, note, comment));
                        context.read<ReadBloc>().add(ReadAddEvent(book, note, comment));
                        SMessenger().menssenger(context, 'Adicionado aos Favoritos', Colors.green);
                        Navigator.pop(context);
                      },
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
