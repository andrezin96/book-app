import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:book_app/widgets/buttons/info_button.dart';
import 'package:book_app/widgets/buttons/read_button.dart';
import 'package:book_app/widgets/buttons/remove_button.dart';
import 'package:book_app/widgets/item_book_list.dart';
import 'package:book_app/widgets/no_data_widget.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteListState) {
            final favorites = state.books;

            if (favorites.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  //favorites.sort((a, b) => a.authors.compareTo(b.authors));

                  final favoriteBook = favorites[index];
                  final bookId = favoriteBook.id;
                  final Book book = Book(
                      favoriteBook['id'],
                      favoriteBook['imageLinks'],
                      favoriteBook['title'],
                      favoriteBook['authors'],
                      favoriteBook['publisher'],
                      favoriteBook['publishedDate'],
                      favoriteBook['description'],
                      favoriteBook['categories'],
                      favoriteBook['pageCount']);

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
                      ReadButton(book: book),
                      RemoveButton(
                        bookId: bookId,
                        onPressed: () {
                          SMessenger().menssenger(context, 'Removido dos Favoritos', Colors.red);
                          context.read<FavoriteBloc>().add(FavoriteRemoveEvent(bookId));
                        },
                      ),
                      InfoButton(
                        onPressed: () {
                          context.read<BookBloc>().add(
                                BookFirebaseInfoEvent(
                                  bookId,
                                  'favorite',
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

          if (state is FavoriteLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is FavoriteErrorState) {
            return Text('Algo deu errado : ${state.error}');
          }

          return NoDataWidget(
              icon: Icon(
                Icons.star,
                size: 100,
                color: Colors.yellow[600],
              ),
              text: 'Você ainda não possui livros Favoritados :(');
        },
      ),
    );
  }
}
