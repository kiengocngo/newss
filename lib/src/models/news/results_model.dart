class Results {
  final String title;
  final String link;
  final String? content;
  final String? description;
  final String? imageUrl;
  final List<String> category;
  
  String? pubDate;
  Results(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.content,
      required this.link,
      required this.category,
      
      this.pubDate});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      title: json['title'],
      description: json['description'] != null ? (json['description']) : null,
      imageUrl: json['image_url'] != null ? (json['image_url']) : null,
      content: json['content'] != null ? (json['content']) : null,
      link: json['link'],
      
      category: json['category'].cast<String>(),
      pubDate: json['pubDate'],
    );
  }
}
