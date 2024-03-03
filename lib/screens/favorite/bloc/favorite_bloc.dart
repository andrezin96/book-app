import 'dart:async';

import 'package:book_app/models/book/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteAddEvent>(addFavorite);
    on<FavoriteRemoveEvent>(removeFavorite);
    on<FavoriteListEvent>(favoriteList);
    on<FavoriteInfoEvent>(favoriteInfo);
  }

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  FutureOr<void> addFavorite(FavoriteAddEvent event, Emitter<FavoriteState> emit) async {
    final String note = event.note;
    final String comment = event.comment;

    try {
      emit(FavoriteLoadingState());

      final favoriteBook = {
        'id': event.favoriteBook.id,
        'imageLinks': event.favoriteBook.imageLinks,
        'title': event.favoriteBook.title,
        'authors': event.favoriteBook.authors,
        'publisher': event.favoriteBook.publisher,
        'publishedDate': event.favoriteBook.publishedDate,
        'description': event.favoriteBook.description,
        'categories': event.favoriteBook.categories,
        'pageCount': event.favoriteBook.pageCount,
        'note': note,
        'comment': comment,
      };

      await db
          .collection('users')
          .doc(auth.currentUser!.email)
          .collection('favorite')
          .doc(event.favoriteBook.id)
          .set(favoriteBook);
      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('favorite').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(FavoriteListState(favorites));
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }

  FutureOr<void> removeFavorite(FavoriteRemoveEvent event, Emitter<FavoriteState> emit) async {
    try {
      final doc = db.collection('users').doc(auth.currentUser!.email).collection('favorite').doc(event.bookId);

      await doc.delete();
      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('favorite').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(FavoriteListState(favorites));
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }

  FutureOr<void> favoriteList(FavoriteListEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoadingState());

      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('favorite').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(FavoriteListState(favorites));
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }

  FutureOr<void> favoriteInfo(FavoriteInfoEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoadingState());
      final docRef = db.collection('usere').doc(auth.currentUser!.email).collection('favorite').doc(event.docId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final comment = data['comment'];
          final note = data['note'];
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(FavortireInfoState(book, comment, note));
        },
        onError: (e) => emit(FavoriteErrorState('$e')),
      );
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }
}
