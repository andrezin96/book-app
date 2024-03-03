import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemBookList extends StatelessWidget {
  const ItemBookList(
      {super.key,
      this.actions,
      required this.id,
      required this.urlImage,
      required this.title,
      required this.author,
      required this.publisher,
      required this.publisherDate,
      required this.description,
      required this.category,
      required this.pages});

  final List<Widget>? actions;
  final String id;
  final String urlImage;
  final String title;
  final String author;
  final String publisher;
  final String publisherDate;
  final String description;
  final String category;
  final String pages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CachedNetworkImage(
              imageUrl: urlImage,
              width: MediaQuery.sizeOf(context).width * 0.22,
              height: 130,
              fit: BoxFit.fill,
              errorWidget: (_, __, ___) => Image.asset('assets/images/no_photo.png'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (author.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.2),
                    child: Text(
                      author,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (category.isNotEmpty) Text('$category - ', style: const TextStyle(fontSize: 12),),
                    Text('$pages páginas', style: const TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions ?? [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
