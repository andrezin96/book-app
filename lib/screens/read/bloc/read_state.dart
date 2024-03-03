part of 'read_bloc.dart';

abstract class ReadState extends Equatable {
  const ReadState();

  @override
  List<Object> get props => [];
}

class ReadInitial extends ReadState {}

class ReadLoadingState extends ReadState {}

class ReadListState extends ReadState {
  final List books;

  const ReadListState(this.books);

  @override
  List<Object> get props => [books];
}

class ReadInfoState extends ReadState {
  final Book book;
  final String comment;
  final String note;

  const ReadInfoState(this.book, this.comment, this.note);

  @override
  List<Object> get props => [book, comment, note];
}

class ReadErrorState extends ReadState {
  final String error;

  const ReadErrorState(this.error);

  @override
  List<Object> get props => [error];
}
