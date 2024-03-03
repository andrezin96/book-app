part of 'book_bloc.dart';

abstract class BookEvent {
  const BookEvent();

  List<Object> get props => [];
}

class BookInitialEvent extends BookEvent {}

class BookSearchEvent extends BookEvent {
  final String terms;

  const BookSearchEvent(this.terms);

  @override
  List<Object> get props => [terms];
}

class BookSearchInfoEvent extends BookEvent {
  final Book book;

  BookSearchInfoEvent(this.book);

  @override
  List<Object> get props => [book];
}

class BookFirebaseInfoEvent extends BookEvent {
  final String bookId;
  final String collection;

  BookFirebaseInfoEvent(this.bookId, this.collection);

  @override
  List<Object> get props => [bookId, collection];
}

class BookTbrInfoEvent extends BookEvent {
  final String bookId;
  final String collection;

  BookTbrInfoEvent(this.bookId, this.collection);

  @override
  List<Object> get props => [bookId, collection];
}

class BookClickEvent extends BookEvent {}

class BookCommentEditEvent extends BookEvent {
  final String collection;
  final String bookId;
  final String comment;
  final String note;

  const BookCommentEditEvent(this.bookId, this.collection, this.comment, this.note);

  @override
  List<Object> get props => [bookId, collection, comment, note];
}