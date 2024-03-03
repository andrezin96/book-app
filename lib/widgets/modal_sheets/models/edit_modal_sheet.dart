import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/widgets/comment_textfield.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditModalSheet extends StatelessWidget {
  const EditModalSheet({
    super.key,
    required this.id,
    required this.collection,
    required this.book,
    required this.comment,
    required this.note,
  });

  final String id;
  final String collection;
  final Book book;
  final String comment;
  final String note;

  @override
  Widget build(BuildContext context) {
    final noteController = TextEditingController(text: note);
    final commentController = TextEditingController(text: comment);

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
                        keyboardType: TextInputType.number,
                        controller: noteController,
                        decoration: const InputDecoration(
                          hintText: 'Nota',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CommentTextField(controller: commentController),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        SMessenger().menssenger(context, 'Editado com Sucesso!', Colors.green);
                        final note = noteController.text.isEmpty ? '' : noteController.text;
                        final comment = commentController.text.isEmpty ? '' : commentController.text;
                        context.read<BookBloc>().add(BookCommentEditEvent(id, collection, comment, note));
                        Navigator.pop(context);
                      },
                      child: const Text('Salvar'),
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