import '../entities/item.dart';
import '../repositories/item_repository.dart';

class GetItems {
  final ItemRepository repository;

  const GetItems(this.repository);

  Future<List<Item>> call() async {
    return await repository.getItems();
  }
}
