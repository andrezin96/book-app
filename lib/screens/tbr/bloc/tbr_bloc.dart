import 'dart:async';

import 'package:book_app/models/book/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tbr_event.dart';
part 'tbr_state.dart';

class TbrBloc extends Bloc<TbrEvent, TbrState> {
  TbrBloc() : super(TbrInitial()) {
    on<TbrAddEvent>(addTbr);
    on<TbrRemoveEvent>(removeTbr);
    on<TbrListEvent>(tbrList);
    on<TbrInfoEvent>(tbrInfo);
  }

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  FutureOr<void> addTbr(TbrAddEvent event, Emitter<TbrState> emit) async {
    try {
      emit(TbrLoadingState());

      final tbrBook = {
        'id': event.tbrBook.id,
        'imageLinks': event.tbrBook.imageLinks,
        'title': event.tbrBook.title,
        'authors': event.tbrBook.authors,
        'publisher': event.tbrBook.publisher,
        'publishedDate': event.tbrBook.publishedDate,
        'description': event.tbrBook.description,
        'categories': event.tbrBook.categories,
        'pageCount': event.tbrBook.pageCount,
      };

      await db.collection('users').doc(auth.currentUser!.email).collection('tbr').doc(event.tbrBook.id).set(tbrBook);
      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('tbr').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(TbrListState(favorites));
    } catch (e) {
      emit(TbrErrorState('$e'));
    }
  }

  FutureOr<void> removeTbr(TbrRemoveEvent event, Emitter<TbrState> emit) async {
    try {
      final doc = db.collection('users').doc(auth.currentUser!.email).collection('tbr').doc(event.bookId);

      await doc.delete();

      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('tbr').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(TbrListState(favorites));
    } catch (e) {
      emit(TbrErrorState('$e'));
    }
  }

  FutureOr<void> tbrList(TbrListEvent event, Emitter<TbrState> emit) async {
    try {
      emit(TbrLoadingState());

      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('tbr').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(TbrListState(favorites));
    } catch (e) {
      emit(TbrErrorState('$e'));
    }
  }

  FutureOr<void> tbrInfo(TbrInfoEvent event, Emitter<TbrState> emit) {

    try {
      emit(TbrLoadingState());
      final docRef = db.collection('usere').doc(auth.currentUser!.email).collection('favorite').doc(event.docId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(TbrInfoState(book));
        },
        onError: (e) => emit(TbrErrorState('$e')),
      );
    } catch (e) {
      emit(TbrErrorState('$e'));
    }
  }
}
