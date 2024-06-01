import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final List<T> items;
  final void Function(T?) onSelected;
  final T? selectedValue;
  final double menuHeight;
  final bool enabled;

  const CustomDropdownMenu({
    super.key,
    required this.controller,
    required this.labelText,
    required this.items,
    required this.onSelected,
    this.selectedValue,
    this.menuHeight = 200.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: DropdownMenu<T>(
          width: MediaQuery.of(context).size.width - 32.0,
          controller: controller,
          enableFilter: true,
          requestFocusOnTap: true,
          label: Text(labelText),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
          onSelected: onSelected,
          dropdownMenuEntries: items.map<DropdownMenuEntry<T>>(
            (T item) {
              return DropdownMenuEntry<T>(
                value: item,
                label: item.toString(),
              );
            },
          ).toList(),
          menuHeight: menuHeight,
        ),
      ),
    );
  }
}
