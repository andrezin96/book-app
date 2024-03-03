import 'package:book_app/models/book/book.dart';
import 'package:book_app/widgets/modal_sheets/models/add_favinfo_modal_sheet.dart';
import 'package:book_app/widgets/modal_sheets/models/edit_modal_sheet.dart';
import 'package:book_app/widgets/modal_sheets/models/add_favorite_modal_sheet.dart';
import 'package:book_app/widgets/modal_sheets/models/add_read_modal_sheet.dart';
import 'package:book_app/widgets/modal_sheets/models/info_modal_sheet.dart';
import 'package:flutter/material.dart';

class ModalSheet {
  void addFavoriteBottomSheet(BuildContext context, Book book) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddFavoriteModalSheet(book: book);
      },
    );
  }

  void addFavInfoBottomSheet(
      BuildContext context, String id, String collection, Book book, String comment, String note) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddFavInfoModalSheet(id: id, collection: collection, book: book, comment: comment, note: note);
      },
    );
  }

  void addReadBottomSheet(BuildContext context, Book book) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddReadModalSheet(book: book);
      },
    );
  }

  void editBottomSheet(BuildContext context, String id, String collection, Book book, String comment, String note) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return EditModalSheet(id: id, collection: collection, book: book, comment: comment, note: note);
      },
    );
  }

  void infoModalSheet(BuildContext context, Book book) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return InfoModalSheet(book: book);
      },
    );
  }
}
