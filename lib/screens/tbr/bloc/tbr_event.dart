part of 'tbr_bloc.dart';

abstract class TbrEvent extends Equatable {
  const TbrEvent();

  @override
  List<Object> get props => [];
}

class TbrAddEvent extends TbrEvent {
  final Book tbrBook;

  const TbrAddEvent(this.tbrBook);

  @override
  List<Object> get props => [tbrBook];
}

class TbrListEvent extends TbrEvent {}

class TbrInfoEvent extends TbrEvent {
  final String docId;

  const TbrInfoEvent(this.docId);

  @override
  List<Object> get props => [docId];
}

class TbrRemoveEvent extends TbrEvent {
  final String bookId;

  const TbrRemoveEvent(this.bookId);

  @override
  List<Object> get props => [bookId];
}
