class Categories {
  final String description;
  Categories({required this.description});
  factory Categories.fromMap(Map<String, dynamic> fromMap) {
    return Categories(description: fromMap['description']);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
    };
  }
}
