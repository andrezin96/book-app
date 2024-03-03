part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteAddEvent extends FavoriteEvent {
  final Book favoriteBook;
  final String note;
  final String comment;

  const FavoriteAddEvent(this.favoriteBook, this.note, this.comment);

  @override
  List<Object> get props => [favoriteBook, note, comment];
}

class FavoriteListEvent extends FavoriteEvent {}

class FavoriteInfoEvent extends FavoriteEvent {
  final String docId;

  const FavoriteInfoEvent(this.docId);

  @override
  List<Object> get props => [docId];
}

class FavoriteRemoveEvent extends FavoriteEvent {
  final String bookId;

  const FavoriteRemoveEvent(this.bookId);

  @override
  List<Object> get props => [bookId];
}