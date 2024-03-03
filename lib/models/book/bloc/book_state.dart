part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoadingState extends BookState {}

class BookSearchState extends BookState {
  final List<Book> books;

  const BookSearchState(this.books);

  @override
  List<Object> get props => [books];
}

class BookSearchInfoState extends BookState {
  final Book book;

  const BookSearchInfoState(this.book);

  @override
  List<Object> get props => [book];
}

class BookFirebaseInfoState extends BookState {
  final Book book;
  final String collection;
  final String comment;
  final String note;

  const BookFirebaseInfoState(this.book, this.collection, this.comment, this.note);

  @override
  List<Object> get props => [book, collection, comment, note];
}

class BookTbrInfoState extends BookState {
  final Book book;
  final String collection;

  const BookTbrInfoState(this.book, this.collection);

  @override
  List<Object> get props => [book, collection];
}

class BookErrorState extends BookState {
  final String error;

  const BookErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class BookClickState extends BookState {}

class BookCommentEditState extends BookState {}

class BookFavoriteListState extends BookState {
  final List books;

  const BookFavoriteListState(this.books);

  @override
  List<Object> get props => [books];
}

class BookReadListState extends BookState {
  final List books;

  const BookReadListState(this.books);

  @override
  List<Object> get props => [books];
}

class BookTbrListState extends BookState {
  final List books;

  const BookTbrListState(this.books);

  @override
  List<Object> get props => [books];
}