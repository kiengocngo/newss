class Categories {
  final int id;
  final String description;
  Categories({required this.id, required this.description});
  factory Categories.fromMap(Map<String, dynamic> categories) {
    return Categories(
        id: categories['id'], description: categories['description']);
  }
  Map<String, Object> toMap() => {
        'id': id,
        'description': description,
      };
}
