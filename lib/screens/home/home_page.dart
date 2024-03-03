import 'package:book_app/models/book/bloc/book_bloc.dart';
import 'package:book_app/screens/home/components/drawer.dart';
import 'package:book_app/screens/home/components/search_textfield/bloc/textfield_bloc.dart';
import 'package:book_app/screens/home/components/streambuilder.dart';
import 'package:book_app/screens/home/components/search_textfield/textfield.dart';
import 'package:book_app/widgets/buttons/favorite_button.dart';
import 'package:book_app/widgets/buttons/info_button.dart';
import 'package:book_app/widgets/buttons/read_button.dart';
import 'package:book_app/widgets/buttons/tbr_button.dart';
import 'package:book_app/widgets/item_book_list.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  

  validate(BuildContext context) {
    if (controller.text.isEmpty) {
      context.read<BookBloc>().add(BookClickEvent());
    } else {
      context.read<BookBloc>().add(BookSearchEvent(controller.text));
    }
  }

  Widget collection(Widget stream) => SizedBox(
        height: 140,
        child: stream,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: BlocSelector<BookBloc, BookState, bool>(
          selector: (state) {
            if (state is BookClickState) {
              return false;
            } else if (state is BookSearchState) {
              return false;
            } else if (state is BookLoadingState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            return IconButton(
              onPressed: () {
                if (state) {
                  _key.currentState!.openDrawer();
                  FocusScope.of(context).unfocus();
                } else {
                  FocusScope.of(context).unfocus();
                  context.read<BookBloc>().add(BookInitialEvent());
                  controller.clear();
                  context.read<TextfieldBloc>().add(TextfieldIsEmptyEvent(controller.text));
                }
              },
              icon: Icon(state ? Icons.menu : Icons.arrow_back),
            );
          },
        ),
        actions: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.85,
            child: MyTextField(
              onTap: () => context.read<BookBloc>().add(BookClickEvent()),
              controller: controller,
              onChanged: (text) {
                validate(context);
                context.read<TextfieldBloc>().add(TextfieldIsEmptyEvent(controller.text));
              },
              onEditingComplete: () {
                validate(context);
                FocusScope.of(context).unfocus();
              },
              onPressed: () => controller.clear(),
              suffixIcon: BlocBuilder<TextfieldBloc, String>(
                builder: (context, state) {
                  return state.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            controller.clear();
                            context.read<BookBloc>().add(BookClickEvent());
                            context.read<TextfieldBloc>().add(TextfieldIsEmptyEvent(controller.text));
                          },
                          icon: const Icon(Icons.clear, size: 20),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BookErrorState) {
              return Text('Livro não encontrado ${state.error}');
            }

            if (state is BookClickState) {
              return PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) async {
                    context.read<BookBloc>().add(BookInitialEvent());
                    controller.clear();
                    return;
                  },
                  child: const SizedBox.shrink());
            }

            if (state is BookSearchState) {
              return ListView.separated(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return PopScope(
                    canPop: false,
                    onPopInvoked: (didPop) async {
                      context.read<BookBloc>().add(BookInitialEvent());
                      controller.clear();
                      return;
                    },
                    child: ItemBookList(
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
                        FavoriteButton(
                          book: book,
                          onPressed: () => ModalSheet().addFavoriteBottomSheet(context, book),
                        ),
                        ReadButton(book: book),
                        TbrButton(book: book),
                        InfoButton(
                          onPressed: () => ModalSheet().infoModalSheet(context, book),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Favoritos',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  collection(
                    StreamBook(
                      bookType: 'favorite',
                      noData: 'Você ainda não possui livros Favoritados :(',
                      icon: Icon(
                        Icons.star,
                        color: Colors.yellow.shade600,
                        size: 50,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Lidos',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  collection(
                    const StreamBook(
                      bookType: 'read',
                      noData: 'Você ainda não possui livros Lidos :(',
                      icon: Icon(
                        Icons.bookmark_added,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'TBR',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  collection(
                    const StreamBook(
                      bookType: 'tbr',
                      noData: 'Você ainda não possui livros em sua TBR :(',
                      icon: Icon(
                        Icons.bookmark_add,
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
