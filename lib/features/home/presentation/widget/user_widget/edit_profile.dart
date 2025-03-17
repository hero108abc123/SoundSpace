import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final String nameTitle;
  final String title;
  final Icon icon;

  const EditProfile({
    super.key,
    required this.nameTitle,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameTitle,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: title,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(179, 226, 226, 226)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              suffixIcon: icon,
            ),
          ),
        ],
      ),
    );
  }
}
