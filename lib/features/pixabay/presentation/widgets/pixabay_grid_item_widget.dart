import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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
      return InkWell(
        onTap: () {
          onTapPreviewImage(context);
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

  void onTapPreviewImage(BuildContext context) {
    final popupWidgetSize =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height * 0.9
            : MediaQuery.of(context).size.width * 0.9;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: InteractiveViewer(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: popupWidgetSize,
              height: popupWidgetSize,
              imageUrl: pixabayImageItemModel.imageUrlLarge,
              placeholder: (context, url) {
                return CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: popupWidgetSize,
                  height: popupWidgetSize,
                  imageUrl: pixabayImageItemModel.imageUrlPreview,
                );
              },
              errorWidget: (context, url, error) {
                return const Center(child: Icon(Icons.broken_image));
              },
            ),
          ),
        );
      },
    );
  }
}
