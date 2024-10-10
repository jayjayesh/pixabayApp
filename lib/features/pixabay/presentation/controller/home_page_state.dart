import 'package:flutter/material.dart';
import 'package:myapp/common/app_constants.dart';
import 'package:myapp/common/environment.dart';
import 'package:myapp/common/models/pixabay_image_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageState extends ChangeNotifier {
  final List<PixabayImageItemModel> _images = [];
  int _page = 1;
  bool _isLoading = false;
  String _searchImageQuery = AppEnumImageSearchTerms.yellowFlowers.value;

  String get searchImageQuery => _searchImageQuery;
  List<PixabayImageItemModel> get images => _images;
  int get page => _page;
  bool get isLoading => _isLoading;

  //
  final pixabayApiKey = Environment.pixabayApiKey;
  final gridViewItemSpacing = 8.0;
  final ScrollController scrollController = ScrollController();
  final searchImageQueryList = [
    AppEnumImageSearchTerms.yellowFlowers,
    AppEnumImageSearchTerms.redRoses,
    AppEnumImageSearchTerms.sunflowers,
    AppEnumImageSearchTerms.tulipFlowers,
    AppEnumImageSearchTerms.lavenderFlowers,
  ];

  // add to images
  void addAllImages(List<PixabayImageItemModel> images) {
    _images.addAll(images);
    notifyListeners();
  }

  // clear images
  void clearImages() {
    _images.clear();
    setPage(1);
    // notifyListeners();
  }

  // set search image query
  void setSearchImageQuery(String query) {
    _searchImageQuery = query;
    clearImages();
    fetchImages();
    // notifyListeners();
  }

  // set page
  void setPage(int page) {
    _page = page;
    // notifyListeners();
  }

  // set loading
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

// OTHER METHODS

  // fetch images
  Future<void> fetchImages() async {
    if (isLoading) return;

    setLoading(true);

    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$pixabayApiKey&q=$searchImageQuery&image_type=photo&per_page=20&page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newImages = (data['hits'] as List)
          .map((item) => PixabayImageItemModel(
              imageUrlPreview: item['previewURL'],
              imageUrlWebFormate: item['webformatURL'],
              imageUrlLarge: item['largeImageURL'],
              likes: item['likes'],
              views: item['views']))
          .toList();

      addAllImages(newImages);
      setPage(page + 1);

      setLoading(false);
    } else {
      setLoading(false);

      throw Exception('Failed to load images');
    }
  }

  // scroll listener
  void scrollListener() {
    if (scrollController.position.pixels >=
            (scrollController.position.maxScrollExtent * 0.6) &&
        !isLoading) {
      fetchImages();
    }
  }
}
