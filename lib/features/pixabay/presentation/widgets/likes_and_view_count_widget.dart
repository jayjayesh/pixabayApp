import 'package:flutter/material.dart';
import 'package:myapp/common/utility.dart';

class LikesAndViewCountWidget extends StatelessWidget {
  const LikesAndViewCountWidget({
    super.key,
    required this.likes,
    required this.views,
  });

  final int likes;
  final int views;

  @override
  Widget build(BuildContext context) {
    final imageLikes = AppUtility.formatNumberToCompactNumber(likes);
    final imageViews = AppUtility.formatNumberToCompactNumber(views);

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
