import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String nameTitle;
  final TextEditingController? controller;
  final String? initialValue;
  final List<String>? options;
  final ValueChanged<String> onChanged;

  const EditProfile({
    super.key,
    required this.nameTitle,
    this.controller,
    this.initialValue,
    this.options,
    required this.onChanged,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.nameTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (widget.options != null && widget.options!.isNotEmpty)
            DropdownButtonFormField<String>(
              value: widget.initialValue,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 94, 94, 94)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 82, 82, 82)),
                ),
              ),
              dropdownColor: Colors.white,
              onChanged: (value) {
                if (value != null) {
                  widget.onChanged(value);
                }
              },
              items: widget.options!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Color.fromARGB(255, 196, 195, 195)),
                  ),
                );
              }).toList(),
            )
          else
            TextFormField(
              controller: _controller,
              style: const TextStyle(color: Color.fromARGB(255, 195, 195, 195)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 95, 95, 95)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 95, 95, 95)),
                ),
              ),
              onChanged: widget.onChanged,
            ),
        ],
      ),
    );
  }
}
