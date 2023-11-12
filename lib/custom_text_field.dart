import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.length,
      {super.key,
      required this.editingController,
      required this.label,
      required this.keyboardType});

  final TextEditingController editingController;
  final String label;
  final int? length;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    // final editController = widget.editingController;
    // final label = widget.label;
    // final length = widget.length;
    // final keyboardType = widget.keyboardType;

    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      keyboardType: keyboardType,
      autofocus: true,
      maxLength: length,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
