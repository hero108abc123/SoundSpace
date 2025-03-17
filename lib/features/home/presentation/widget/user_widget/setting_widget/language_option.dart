import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageOption extends StatelessWidget {
  final String language;
  final String flagImagePath;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const LanguageOption({
    super.key,
    required this.language,
    required this.flagImagePath,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Image.asset(
            flagImagePath,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            language,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
