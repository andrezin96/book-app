import 'package:book_app/models/book/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListViewBooks extends StatelessWidget {
  const ListViewBooks({super.key, required this.books, required this.onTap});

  final List books;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final item = books[index];
        final Book book = Book(
          item['id'],
          item['imageLinks'],
          item['title'],
          item['authors'],
          item['publisher'],
          item['publishedDate'],
          item['description'],
          item['categories'],
          item['pageCount'],
        );

        return Padding(
          padding: const EdgeInsets.only(top: 10, right: 8),
          child: GestureDetector(
            onTap: () {
              onTap;
              Navigator.pushNamed(context, '/info');
            },
            child: SizedBox(
              width: 90,
              child: CachedNetworkImage(
                imageUrl: book.imageLinks,
                fit: BoxFit.fill,
                errorWidget: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
    );
  }
}