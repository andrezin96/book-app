import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.note,
  });

  final String comment;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 22, bottom: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              comment,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            Text('Nota: $note'),
          ],
        ),
      ),
    );
  }
}
