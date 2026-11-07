import '../../domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    super.id,
    required super.name,
    super.description,
    super.imagePath,
    required super.createdAt,
    required super.updatedAt,
  });

  // Convert SQLite Map into ItemModel
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String?,
      imagePath: map['imagePath'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  // Convert ItemModel into SQLite Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
