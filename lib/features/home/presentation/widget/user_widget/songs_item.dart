import 'package:flutter/material.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';

class SongsItem extends StatelessWidget {
  final Track track;
  final Function(Track) onNavigate;

  const SongsItem({
    super.key,
    required this.track,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => onNavigate(track),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
          leading: SizedBox(
            width: 50.0,
            height: 50.0,
            child: ClipOval(
              child: Image.network(
                track.image,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
          ),
          title: Text(
            track.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            track.artist,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          tileColor: Colors.transparent,
        ),
      ),
    );
  }
}
