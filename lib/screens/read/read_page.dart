import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/read/bloc/read_bloc.dart';
import 'package:book_app/widgets/buttons/favorite_button.dart';
import 'package:book_app/widgets/buttons/info_button.dart';
import 'package:book_app/widgets/buttons/remove_button.dart';
import 'package:book_app/widgets/item_book_list.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:book_app/widgets/no_data_widget.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lidos'),
      ),
      body: BlocBuilder<ReadBloc, ReadState>(
        builder: (context, state) {
          if (state is ReadListState) {
            final reads = state.books;

            if (reads.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: reads.length,
                itemBuilder: (context, index) {
                  //reads.sort((a, b) => a.authors.compareTo(b.authors));
                  final readBook = reads[index];
                  final bookId = readBook.id;
                  final Book book = Book(
                    readBook['id'],
                    readBook['imageLinks'],
                    readBook['title'],
                    readBook['authors'],
                    readBook['publisher'],
                    readBook['publishedDate'],
                    readBook['description'],
                    readBook['categories'],
                    readBook['pageCount'],
                  );

                  return ItemBookList(
                    id: book.id,
                    urlImage: book.imageLinks,
                    title: book.title,
                    author: book.authors,
                    publisher: book.publisher,
                    publisherDate: book.publishedDate,
                    description: book.description,
                    category: book.categories,
                    pages: book.pageCount.toString(),
                    actions: [
                      FavoriteButton(book: book, onPressed: () => ModalSheet().addFavoriteBottomSheet(context, book),),
                      RemoveButton(
                        bookId: bookId,
                        onPressed: () {
                          SMessenger().menssenger(context, 'Removido dos Lidos!', Colors.red);
                          context.read<ReadBloc>().add(ReadRemoveEvent(bookId));
                        },
                      ),
                      InfoButton(
                        onPressed: () {
                          context.read<BookBloc>().add(
                                BookFirebaseInfoEvent(
                                  bookId,
                                  'read',
                                ),
                              );
                          Navigator.pushNamed(context, '/info');
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }

          if (state is ReadLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is ReadErrorState) {
            return Text('Algo deu errado : ${state.error}');
          }

          return const NoDataWidget(
              icon: Icon(
                Icons.bookmark_added,
                size: 100,
                color: Colors.green,
              ),
              text: 'Você ainda não possui livros Lidos :(');
        },
      ),
    );
  }
}
