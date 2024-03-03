import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/widgets/no_data_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamBook extends StatelessWidget {
  const StreamBook({super.key, required this.bookType, required this.noData, required this.icon});

  final String bookType;
  final String noData;
  final Icon icon;

  onTap(BuildContext context, String bookType, String bookId, Book book) {
    if (bookType == 'tbr') {
      context.read<BookBloc>().add(BookTbrInfoEvent(
          bookId, bookType));
    } else if (bookType == 'favorite') {
      context
          .read<BookBloc>()
          .add(BookFirebaseInfoEvent(bookId, bookType));
    } else if (bookType == 'read') {
      context
          .read<BookBloc>()
          .add(BookFirebaseInfoEvent(bookId, bookType));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    final bookList = db.collection('users').doc(auth.currentUser!.email).collection(bookType);

    return StreamBuilder(
      stream: bookList.orderBy('authors').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('erro: ${snapshot.error}');
        }

        if (snapshot.data!.docs.isEmpty) {
          return NoDataWidget(
              icon: icon,
              text: noData);
        }

        final QuerySnapshot querySnapshot = snapshot.data!;
        final List<DocumentSnapshot> books = querySnapshot.docs;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            final item = books[index];
            final bookId = item['id'];
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
                  onTap(context, bookType, bookId, book);
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
      },
    );
  }
}
