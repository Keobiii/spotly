import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../data/datasources/local/item_local_data_source.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../domain/repositories/item_repository.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/get_items.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance;
});

final itemLocalDataSourceProvider = Provider<ItemLocalDataSource>((ref) {
  final appDatabase = ref.watch(appDatabaseProvider);

  return ItemLocalDataSource(appDatabase);
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final localDataSource = ref.watch(itemLocalDataSourceProvider);

  return ItemRepositoryImpl(localDataSource);
});

final addItemProvider = Provider<AddItem>((ref) {
  final repository = ref.watch(itemRepositoryProvider);

  return AddItem(repository);
});

final getItemsProvider = Provider<GetItems>((ref) {
  final repository = ref.watch(itemRepositoryProvider);

  return GetItems(repository);
});
