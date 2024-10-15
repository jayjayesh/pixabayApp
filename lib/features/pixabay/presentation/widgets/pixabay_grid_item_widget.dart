import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/models/pixabay_image_item_model.dart';
import 'package:myapp/features/pixabay/presentation/widgets/likes_and_view_count_widget.dart';

class PixabayGridItemWidget extends StatelessWidget {
  const PixabayGridItemWidget({
    super.key,
    required this.pixabayImageItemModel,
    this.onTapPreviewImage,
  });

  final PixabayImageItemModel pixabayImageItemModel;
  final void Function()? onTapPreviewImage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          onTapPreviewImage?.call();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              //image: NetworkImage(image.imageUrl),
              image: CachedNetworkImageProvider(
                pixabayImageItemModel.imageUrlPreview,
                maxHeight: constraints.maxHeight.toInt(),
                maxWidth: constraints.maxWidth.toInt(),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${MediaQuery.of(context).size.width ~/ 210}',
                style: const TextStyle(
                  color: kDebugMode ? Colors.white : Colors.transparent,
                ),
              ),
              Text(
                '${constraints.maxHeight.toInt()} x ${constraints.maxWidth.toInt()}',
                style: const TextStyle(
                  color: kDebugMode ? Colors.white : Colors.transparent,
                ),
              ),
              LikesAndViewCountWidget(
                likes: pixabayImageItemModel.likes,
                views: pixabayImageItemModel.views,
              ),
            ],
          ),
        ),
      );
    });
  }
}
