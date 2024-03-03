import 'dart:async';
import 'dart:convert';
import 'package:book_app/models/book/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<BookInitialEvent>((event, emit) => emit(BookInitial()));
    on<BookSearchEvent>(searchBooks);
    on<BookSearchInfoEvent>(searchInfo);
    on<BookFirebaseInfoEvent>(firebaseInfo);
    on<BookTbrInfoEvent>(tbrInfo);
    on<BookClickEvent>((event, emit) => emit(BookClickState()));
    on<BookCommentEditEvent>(edit);
  }

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  FutureOr<void> searchInfo(BookSearchInfoEvent event, Emitter<BookState> emit) {
    try {
      emit(BookLoadingState());
      emit(BookSearchInfoState(event.book));
    } catch (e) {
      emit(BookErrorState('Algo deu errado: $e'));
    }
  }

  Future<List<Book>> fetchBooks(String terms, {int startIndex = 0, int maxResults = 40}) async {
    const apiKey = 'AIzaSyDy3GFxGQZhm7TMvmKcPG121ArI_tgNmKo';
    const apiUrl = 'https://www.googleapis.com/books/v1/volumes';
    final response = await http.get(
        //Uri.parse('$apiUrl?q=$terms&time&printType=books&startIndex=$startIndex&maxResults=$maxResults&key=$apiKey'));
        Uri.parse('$apiUrl?q=$terms&startIndex=$startIndex&maxResults=$maxResults&key=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['items'];
      return data.map((json) => Book.fromJson({'id': json['id'], 'volumeInfo': json['volumeInfo']})).toList();
    } else {
      throw Exception('Falha ao buscar livro');
    }
  }

  FutureOr<void> searchBooks(BookSearchEvent event, Emitter<BookState> emit) async {
    try {
      emit(BookLoadingState());

      final List<Book> books = await fetchBooks(event.terms);
      emit(BookSearchState(books));
    } catch (e) {
      emit(BookErrorState('$e'));
    }
  }

  FutureOr<void> firebaseInfo(BookFirebaseInfoEvent event, Emitter<BookState> emit) async {
    try {
      emit(BookLoadingState());

      final docRef = db.collection('users').doc(auth.currentUser!.email).collection(event.collection).doc(event.bookId);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final String comment = data['comment'];
          final String note = data['note'];
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(BookFirebaseInfoState(book, event.collection, comment, note));
        },
        onError: (e) => emit(BookErrorState('$e')),
      );
    } catch (e) {
      emit(BookErrorState('$e'));
    }
  }

  FutureOr<void> edit(BookCommentEditEvent event, Emitter<BookState> emit) async {
    final doc = db.collection('users').doc(auth.currentUser!.email).collection(event.collection).doc(event.bookId);

    try {
      emit(BookLoadingState());

      final update = {
        'comment': event.comment,
        'note': event.note,
      };

      doc.update(update);
      final docRef = db.collection('users').doc(auth.currentUser!.email).collection(event.collection).doc(event.bookId);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final String comment = data['comment'];
          final String note = data['note'];
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(BookFirebaseInfoState(book, event.collection, comment, note));
        },
      );
    } catch (e) {
      emit(BookErrorState('Erro ao editar - $e'));
    }
  }

  FutureOr<void> tbrInfo(BookTbrInfoEvent event, Emitter<BookState> emit) async {
    try {
      emit(BookLoadingState());

      final docRef = db.collection('users').doc(auth.currentUser!.email).collection(event.collection).doc(event.bookId);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          final Book book = Book(data['id'], data['imageLinks'], data['title'], data['authors'], data['publisher'],
              data['publishedDate'], data['description'], data['categories'], data['pageCount']);
          emit(BookTbrInfoState(book, event.collection));
        },
        onError: (e) => emit(BookErrorState('$e')),
      );
    } catch (e) {
      emit(BookErrorState('$e'));
    }
  }
}
