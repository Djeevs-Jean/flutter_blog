
class ArticleItem {
  final int id;
  final String title;
  final String body;
  // final String summary;

  ArticleItem({required this.id, required this.title, required this.body});
  // ArticleItem({required this.imageUrl, required this.title, required this.date, required this.summary});

  factory ArticleItem.fromJSON(Map<String, dynamic> json) {
    return ArticleItem(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}