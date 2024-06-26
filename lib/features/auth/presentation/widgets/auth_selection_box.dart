import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class AuthSelectionBox extends StatefulWidget {
  final List<String> list;
  final String? child;
  const AuthSelectionBox({super.key, required this.list, required this.child});

  @override
  State<AuthSelectionBox> createState() => _AuthSelectionBoxState();
}

class _AuthSelectionBoxState extends State<AuthSelectionBox> {
  String? currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      isDense: true,
      hint: const Text(
        "Select your gender",
        style: TextStyle(
          color: AppPallete.whiteColor,
        ),
      ),
      value: currentItem,
      style: const TextStyle(
        color: AppPallete.borderColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          currentItem = value!;
        });
      },
      dropdownColor: AppPallete.boxColor,
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
