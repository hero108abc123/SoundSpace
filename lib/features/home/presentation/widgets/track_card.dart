import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.track,
  });

  final TrackModel track;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/track', arguments: track);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(
                    track.coverUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.38,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppPallete.boxColor.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        track.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppPallete.gradient4,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        track.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppPallete.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: AppPallete.gradient4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
