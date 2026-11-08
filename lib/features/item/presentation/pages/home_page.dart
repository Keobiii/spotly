import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotly/core/theme/app_theme.dart';

import '../../domain/entities/item.dart';
import '../notifiers/item_notifier.dart';
import '../widgets/add_item_dialog.dart';
import '../widgets/item_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<void> _showAddItemDialog() async {
    final item = await showDialog<Item>(
      context: context,
      builder: (context) {
        return const AddItemDialog();
      },
    );

    if (item == null) return;

    await _addItem(item);
  }

  Future<void> _addItem(Item item) async {
    try {
      await ref.read(itemNotifierProvider.notifier).addItem(item);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item added successfully!')));
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add item: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotly'),
        backgroundColor: AppTheme.background,
      ),
      backgroundColor: AppTheme.background,

      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => Center(child: Text('Error: $error')),

        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ItemCard(item: item),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
