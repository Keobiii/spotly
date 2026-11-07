class Item {
  final int? id;
  final String name;
  final String? description;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    this.id,
    required this.name,
    this.description,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });
}
