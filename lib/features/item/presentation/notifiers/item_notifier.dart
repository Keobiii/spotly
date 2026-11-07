import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/item.dart';
import '../providers/item_providers.dart';

final itemNotifierProvider = AsyncNotifierProvider<ItemNotifier, List<Item>>(
  ItemNotifier.new,
);

class ItemNotifier extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() async {
    final getItems = ref.read(getItemsProvider);

    return await getItems();
  }

  Future<void> addItem(Item item) async {
    final addItem = ref.read(addItemProvider);

    await addItem(item);

    // Refresh the list after inserting.
    final getItems = ref.read(getItemsProvider);

    state = AsyncData(await getItems());
  }
}
