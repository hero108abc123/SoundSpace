import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  const SectionHeader({
    super.key,
    required this.title,
    this.action = 'View More',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppPallete.whiteColor,
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          action,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppPallete.whiteColor),
        ),
      ],
    );
  }
}
