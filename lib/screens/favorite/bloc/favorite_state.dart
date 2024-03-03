part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteListState extends FavoriteState {
  final List books;

  const FavoriteListState(this.books);

  @override
  List<Object> get props => [books];
}

class FavortireInfoState extends FavoriteState {
  final Book book;
  final String comment;
  final String note;

  const FavortireInfoState(this.book, this.comment, this.note);

  @override
  List<Object> get props => [book, comment, note];
}

class FavoriteErrorState extends FavoriteState {
  final String error;

  const FavoriteErrorState(this.error);

  @override
  List<Object> get props => [];
}
