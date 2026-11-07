import 'package:spotly/features/item/domain/entities/item.dart';

import '../../domain/repositories/item_repository.dart';
import '../datasources/local/item_local_data_source.dart';
import '../models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemLocalDataSource localDataSource;

  const ItemRepositoryImpl(this.localDataSource);

  @override
  Future<void> addItem(Item item) {
    final itemModel = ItemModel(
      id: item.id,
      name: item.name,
      description: item.description,
      imagePath: item.imagePath,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );

    return localDataSource.addItem(itemModel);
  }

  @override
  Future<List<Item>> getItems() async {
    final itemModels = await localDataSource.getItems();

    return itemModels;
  }
}
