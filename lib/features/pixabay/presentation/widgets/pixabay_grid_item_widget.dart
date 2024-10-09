
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/pixabay/presentation/widgets/likes_and_view_count_widget.dart';

class PixabayGridItemWidget extends StatelessWidget {
  const PixabayGridItemWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final image = _images[index];

    return LayoutBuilder(builder: (context, constraints) {
      return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            //image: NetworkImage(image.imageUrl),
            image: CachedNetworkImageProvider(
              image.imageUrl,
              maxHeight: constraints.maxHeight.toInt(),
              maxWidth: constraints.maxWidth.toInt(),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${constraints.maxHeight.toInt()} x ${constraints.maxWidth.toInt()}',
                style: const TextStyle(color: Colors.white)),
            LikesAndViewCountWidget(index: index),
          ],
        ),
      );
    });
  }
}
