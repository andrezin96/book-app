part of 'tbr_bloc.dart';

abstract class TbrState extends Equatable {
  const TbrState();

  @override
  List<Object> get props => [];
}

class TbrInitial extends TbrState {}

class TbrLoadingState extends TbrState {}

class TbrListState extends TbrState {
  final List books;

  const TbrListState(this.books);

  @override
  List<Object> get props => [books];
}

class TbrInfoState extends TbrState {
  final Book book;

  const TbrInfoState(this.book);

  @override
  List<Object> get props => [book];
}

class TbrErrorState extends TbrState {
  final String error;

  const TbrErrorState(this.error);

  @override
  List<Object> get props => [error];
}
