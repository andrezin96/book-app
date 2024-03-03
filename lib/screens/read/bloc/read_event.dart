part of 'read_bloc.dart';

abstract class ReadEvent extends Equatable {
  const ReadEvent();

  @override
  List<Object> get props => [];
}

class ReadAddEvent extends ReadEvent {
  final Book readBook;
  final String note;
  final String comment;

  const ReadAddEvent(this.readBook, this.note, this. comment);

  @override
  List<Object> get props => [readBook, note, comment];
}

class ReadListEvent extends ReadEvent {}

class ReadInfoEvent extends ReadEvent {
  final String docId;

  const ReadInfoEvent(this.docId);

  @override
  List<Object> get props => [docId];
}

class ReadRemoveEvent extends ReadEvent {
  final String bookId;

  const ReadRemoveEvent(this.bookId);

  @override
  List<Object> get props => [bookId];
}