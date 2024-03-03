import 'dart:async';

import 'package:book_app/models/book/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'read_event.dart';
part 'read_state.dart';

class ReadBloc extends Bloc<ReadEvent, ReadState> {
  ReadBloc() : super(ReadInitial()) {
    on<ReadAddEvent>(addRead);
    on<ReadRemoveEvent>(removeRead);
    on<ReadListEvent>(readList);
    on<ReadInfoEvent>(readInfo);
  }

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  FutureOr<void> addRead(ReadAddEvent event, Emitter<ReadState> emit) async {
    final String note = event.note;
    final String comment = event.comment;

    try {
      emit(ReadLoadingState());

      final readBook = {
        'id': event.readBook.id,
        'imageLinks': event.readBook.imageLinks,
        'title': event.readBook.title,
        'authors': event.readBook.authors,
        'publisher': event.readBook.publisher,
        'publishedDate': event.readBook.publishedDate,
        'description': event.readBook.description,
        'categories': event.readBook.categories,
        'pageCount': event.readBook.pageCount,
        'note': note,
        'comment': comment,
      };

      await db.collection('users').doc(auth.currentUser!.email).collection('read').doc(event.readBook.id).set(readBook);
      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('read').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(ReadListState(favorites));
    } catch (e) {
      emit(ReadErrorState('$e'));
    }
  }

  // Future<void> teste() async {
  //   final books = await db
  //       .collection('users')
  //       .doc(auth.currentUser!.email)
  //       .collection('read')
  //       .withConverter(
  //         fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
  //         toFirestore: (book, _) => {},
  //       )
  //       .get();

  //   state.books = books.docs.map((e) => e.data()).toList();
  // }

  FutureOr<void> removeRead(ReadRemoveEvent event, Emitter<ReadState> emit) async {
    try {
      final doc = db.collection('users').doc(auth.currentUser!.email).collection('read').doc(event.bookId);

      await doc.delete();

      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('read').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(ReadListState(favorites));
    } catch (e) {
      emit(ReadErrorState('$e'));
    }
  }

  FutureOr<void> readList(ReadListEvent event, Emitter<ReadState> emit) async {
    try {
      emit(ReadLoadingState());

      final querySnapshot = await db.collection('users').doc(auth.currentUser!.email).collection('read').get();
      final List<DocumentSnapshot> favorites = querySnapshot.docs;
      emit(ReadListState(favorites));
    } catch (e) {
      emit(ReadErrorState('$e'));
    }
  }

  FutureOr<void> readInfo(ReadInfoEvent event, Emitter<ReadState> emit) {

    try {
      emit(ReadLoadingState());
      final docRef = db.collection('usere').doc(auth.currentUser!.email).collection('read').doc(event.docId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final comment = data['comment'];
          final note = data['note'];
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(ReadInfoState(book, comment, note));
        },
        onError: (e) => emit(ReadErrorState('$e')),
      );
    } catch (e) {
      emit(ReadErrorState('$e'));
    }
  }
}
