
import 'package:flutter/material.dart';
import 'package:myapp/common/utility.dart';

class LikesAndViewCountWidget extends StatelessWidget {
  const LikesAndViewCountWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final image = _images[index];
    final imageLikes = AppUtility.formatNumberToCompactNumber(image.likes);
    final imageViews = AppUtility.formatNumberToCompactNumber(image.views);

    return Container(
      height: 40,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black54, Colors.black12],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Likes: $imageLikes',
              style: const TextStyle(color: Colors.white)),
          Text('Views: $imageViews',
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
