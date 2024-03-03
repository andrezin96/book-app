import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/tbr/bloc/tbr_bloc.dart';
import 'package:book_app/widgets/buttons/favorite_button.dart';
import 'package:book_app/widgets/buttons/info_button.dart';
import 'package:book_app/widgets/buttons/read_button.dart';
import 'package:book_app/widgets/buttons/remove_button.dart';
import 'package:book_app/widgets/item_book_list.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:book_app/widgets/no_data_widget.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TbrPage extends StatelessWidget {
  const TbrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TBR'),
      ),
      body: BlocBuilder<TbrBloc, TbrState>(
        builder: (context, state) {
          if (state is TbrListState) {
            final tbrs = state.books;

            if (tbrs.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: tbrs.length,
                itemBuilder: (context, index) {
                  //tbrs.sort((a, b) => a.authors.compareTo(b.authors));
                  final tbrBook = tbrs[index];
                  final bookId = tbrBook.id;
                  final Book book = Book(
                      tbrBook['id'],
                      tbrBook['imageLinks'],
                      tbrBook['title'],
                      tbrBook['authors'],
                      tbrBook['publisher'],
                      tbrBook['publishedDate'],
                      tbrBook['description'],
                      tbrBook['categories'],
                      tbrBook['pageCount']);

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
                      ReadButton(book: book),
                      RemoveButton(
                        bookId: bookId,
                        onPressed: () {
                          SMessenger().menssenger(context, 'Removido da sua Tbr', Colors.red);
                          context.read<TbrBloc>().add(TbrRemoveEvent(bookId));
                        },
                      ),
                      InfoButton(
                        onPressed: () {
                          context.read<BookBloc>().add(
                                BookTbrInfoEvent(bookId, 'tbr'),
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

          if (state is TbrLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is TbrErrorState) {
            return Text('Algo deu errado : ${state.error}');
          }

          return const NoDataWidget(
              icon: Icon(
                Icons.bookmark_add,
                size: 100,
                color: Colors.blue,
              ),
              text: 'Você ainda não possui livros em sua TBR :(');
        },
      ),
    );
  }
}
