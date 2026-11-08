class Item {
  final int? id;
  final String name;
  final String location;
  final String? description;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    this.id,
    required this.name,
    required this.location,
    this.description,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });
}
