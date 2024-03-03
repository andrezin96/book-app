class Book {
  final String id;
  final String imageLinks;
  final String title;
  final String authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final String categories;
  final int pageCount;

  Book(
    this.id,
    this.imageLinks,
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.categories,
    this.pageCount,
  );

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      map['id'],
      map['imageLinks'],
      map['title'],
      map['authors'],
      map['publisher'],
      map['publishedDate'],
      map['description'],
      map['categories'],
      map['pageCount'],
    );
  }

  factory Book.fromJson(Map json) {
    final id = json['id'] ?? '';
    final imageLinks = json['volumeInfo']?['imageLinks']?['thumbnail'] ?? '';
    final title = json['volumeInfo']['title'] ?? '';
    final authors =
        (json['volumeInfo']['authors'] as List<dynamic>?)?.map((authors) => authors.toString()).join(', ') ?? '';
    final publisher = json['volumeInfo']['publisher'] ?? '';
    final publishedDate = json['volumeInfo']['publishedDate'] ?? '';
    final description = json['volumeInfo']['description'] ?? '';
    final categories =
        (json['volumeInfo']['categories'] as List<dynamic>?)?.map((categories) => categories.toString()).join(', ') ??
            '';
    final pageCount = json['volumeInfo']['pageCount'] ?? 0;

    return Book(id, imageLinks, title, authors, publisher, publishedDate, description, categories, pageCount);
  }

  ({String url, String title, String authors, String categories, String pageCount}) get getForItem => (
        url: imageLinks,
        title: title,
        authors: authors,
        categories: categories,
        pageCount: pageCount.toString(),
      );
}
