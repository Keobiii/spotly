import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/item.dart';
import 'app_text_field.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _imagePicker = ImagePicker();

  String? _imagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _imagePath = image.path;
    });
  }

  void _saveItem() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();

    final item = Item(
      name: _nameController.text.trim(),
      location: _locationController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      imagePath: _imagePath,
      createdAt: now,
      updatedAt: now,
    );

    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Item name
              AppTextField(
                label: 'Item Name',
                hintText: 'Enter item name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an item name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Location
              AppTextField(
                label: 'Location',
                hintText: 'Enter location',
                controller: _locationController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a location';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Description
              AppTextField(
                label: 'Description',
                hintText: 'Optional',
                controller: _descriptionController,
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              // Image
              if (_imagePath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(_imagePath!)),
                ),
                const SizedBox(height: 8),
              ],

              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_outlined),
                label: Text(
                  _imagePath == null ? 'Select Photo' : 'Change Photo',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveItem, child: const Text('Save')),
      ],
    );
  }
}
