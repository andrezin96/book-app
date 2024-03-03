import 'package:flutter/material.dart';

class DataTableBook extends StatelessWidget {
  const DataTableBook({super.key, required this.pages, required this.publisher, required this.category});

  final int pages;
  final String publisher;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Text(pages.toString()),
              ),
              DataCell(
                Text(publisher),
              ),
              DataCell(
                Text(category),
              ),
            ],
          ),
        ],
      ),
    );
  }
}