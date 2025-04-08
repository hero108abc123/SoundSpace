import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';

class FollowWidget extends StatelessWidget {
  final Artist user;
  final Icon icon;
  final VoidCallback onPressed;

  const FollowWidget({
    super.key,
    required this.user,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.network(
              user.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${user.followersCount} followers • ${user.followingCount} following',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: icon,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
