import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/models/book/book.dart';
import 'package:book_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:book_app/screens/info/components/comment_card.dart';
import 'package:book_app/screens/info/components/data_table.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:book_app/widgets/modal_sheets/models/edit_modal_sheet.dart';
import 'package:book_app/screens/read/bloc/read_bloc.dart';
import 'package:book_app/screens/tbr/bloc/tbr_bloc.dart';
import 'package:book_app/widgets/buttons/favorite_button.dart';
import 'package:book_app/widgets/buttons/read_button.dart';
import 'package:book_app/widgets/buttons/remove_button.dart';
import 'package:book_app/widgets/scaffold_messenger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, this.actions});

  final Widget? actions;

  void modalSheet(BuildContext context, String id, String collection, Book book, String comment, String note) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return EditModalSheet(
          id: id,
          collection: collection,
          book: book,
          comment: comment,
          note: note,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookFirebaseInfoState) {
            final String comment = state.comment;
            final String note = state.note;
            final String id = state.book.id;
            final String collection = state.collection;
            final book = state.book;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 46, right: 16, left: 16, bottom: 16),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: book.imageLinks,
                        fit: BoxFit.fill,
                        errorWidget: (_, __, ___) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        book.authors,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      DataTableBook(pages: book.pageCount, publisher: book.publisher, category: book.categories),
                      Stack(
                        children: [
                          CommentCard(comment: comment, note: note),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                                onPressed: () =>
                                    ModalSheet().editBottomSheet(context, id, collection, book, comment, note),
                                icon: const Icon(Icons.edit_note)),
                          ),
                        ],
                      ),
                      Text(
                        book.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (state.collection == 'read')
                          FavoriteButton(
                              book: book,
                              onPressed: () =>
                                  ModalSheet().addFavInfoBottomSheet(context, id, collection, book, comment, note)),
                        RemoveButton(
                          bookId: id,
                          onPressed: () {
                            if (state.collection == 'favorite') {
                              context.read<FavoriteBloc>().add(FavoriteRemoveEvent(id));
                              SMessenger().menssenger(context, 'Removido dos Favoritos!', Colors.red);
                            } else {
                              context.read<ReadBloc>().add(ReadRemoveEvent(id));
                              SMessenger().menssenger(context, 'Removido dos Lidos!', Colors.red);
                            }

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                ],
              ),
            );
          }

          if (state is BookTbrInfoState) {
            final book = state.book;
            final id = book.id;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 46, right: 16, left: 16, bottom: 16),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: book.imageLinks,
                        fit: BoxFit.fill,
                        errorWidget: (_, __, ___) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        book.authors,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      DataTableBook(pages: book.pageCount, publisher: book.publisher, category: book.categories),
                      Text(
                        book.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      children: [
                        FavoriteButton(
                          book: book,
                          onPressed: () => ModalSheet().addFavoriteBottomSheet(context, book),
                        ),
                        ReadButton(book: book),
                        RemoveButton(
                          bookId: id,
                          onPressed: () {
                            context.read<TbrBloc>().add(TbrRemoveEvent(id));
                            SMessenger().menssenger(context, 'Removido da sua TBR!', Colors.red);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                ],
              ),
            );
          }

          if (state is BookLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookErrorState) {
            return Text(state.error);
          }

          return const Text('sem info');
        },
      ),
    );
  }
}
