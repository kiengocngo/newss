class Categories {
  final String description;
  Categories({required this.description});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
    };
  }
}
