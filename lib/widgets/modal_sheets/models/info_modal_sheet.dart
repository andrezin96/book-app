import 'package:book_app/models/book/book.dart';
import 'package:book_app/widgets/buttons/favorite_button.dart';
import 'package:book_app/widgets/buttons/read_button.dart';
import 'package:book_app/widgets/buttons/tbr_button.dart';
import 'package:book_app/widgets/modal_sheets/modal__sheet_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoModalSheet extends StatelessWidget {
  const InfoModalSheet({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              children: [
                FavoriteButton(book: book, onPressed: () => ModalSheet().addFavoriteBottomSheet(context, book),),
                ReadButton(book: book),
                TbrButton(book: book),
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))),
          Column(
            children: [
              SizedBox(
                height: 180,
                width: 130,
                child: CachedNetworkImage(
                  imageUrl: book.imageLinks,
                  fit: BoxFit.fill,
                  errorWidget: (_, __, ___) => const SizedBox(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                book.authors,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('Páginas'),
                    ),
                    DataColumn(
                      label: Text('Editora'),
                    ),
                    DataColumn(
                      label: Text('Gênero'),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(book.pageCount.toString()),
                        ),
                        DataCell(
                          Text(book.publisher),
                        ),
                        DataCell(
                          Text(book.categories),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 350,
                child: SingleChildScrollView(
                  child: Text(
                    book.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
