import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/models/pixabay_image_item_model.dart';
import 'package:myapp/features/pixabay/presentation/widgets/likes_and_view_count_widget.dart';

class PixabayGridItemWidget extends StatelessWidget {
  const PixabayGridItemWidget({
    super.key,
    required this.pixabayImageItemModel,
  });

  final PixabayImageItemModel pixabayImageItemModel;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            //image: NetworkImage(image.imageUrl),
            image: CachedNetworkImageProvider(
              pixabayImageItemModel.imageUrl,
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
            LikesAndViewCountWidget(
              likes: pixabayImageItemModel.likes,
              views: pixabayImageItemModel.views,
            ),
          ],
        ),
      );
    });
  }
}
