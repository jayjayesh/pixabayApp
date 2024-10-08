// Suggested code may be subject to a license. Learn more: ~LicenseLog:2022858007.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:980123772.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1752391765.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2565976469.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3162804888.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1200432839.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1567601484.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/common/environment.dart';

import 'package:myapp/common/utility.dart';

class ImageItemModel {
  final String imageUrl;
  final int likes;

  final int views;

  ImageItemModel({
    required this.imageUrl,
    required this.likes,
    required this.views,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ImageItemModel> _images = [];
  int _page = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final pixabayApiKey = Environment.pixabayApiKey;
  final gridViewItemSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchImages() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$pixabayApiKey&q=yellow+flowers&image_type=photo&per_page=20&page=$_page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newImages = (data['hits'] as List)
          .map((item) => ImageItemModel(
              imageUrl: item['webformatURL'],
              likes: item['likes'],
              views: item['views']))
          .toList();

      setState(() {
        _images.addAll(newImages);
        _page++;

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load images');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            (_scrollController.position.maxScrollExtent * 0.6) &&
        !_isLoading) {
      _fetchImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pixabay Images'),
      // ),
      body: GridView.builder(
        padding: EdgeInsets.only(
          top: gridViewItemSpacing,
          left: gridViewItemSpacing,
          right: gridViewItemSpacing,
          bottom: MediaQuery.of(context).size.height * 0.4,
        ),
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 190,
          crossAxisSpacing: gridViewItemSpacing,
          mainAxisSpacing: gridViewItemSpacing,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          final imageLikes =
              AppUtility.formatNumberToCompactNumber(image.likes);
          final imageViews =
              AppUtility.formatNumberToCompactNumber(image.views);

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
                  Container(
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
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
