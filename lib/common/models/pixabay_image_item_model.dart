class PixabayImageItemModel {
  final String imageUrlPreview;
  final String imageUrlWebFormate;
  final String imageUrlLarge;
  final int likes;
  final int views;

  PixabayImageItemModel({
    required this.imageUrlPreview,
    required this.imageUrlWebFormate,
    required this.imageUrlLarge,
    required this.likes,
    required this.views,
  });
}
