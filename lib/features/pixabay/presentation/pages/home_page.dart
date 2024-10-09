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
import 'package:myapp/common/environment.dart';
import 'package:myapp/common/models/pixabay_image_item_model.dart';
import 'package:myapp/features/pixabay/presentation/widgets/pixabay_grid_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PixabayImageItemModel> _images = [];
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
          .map((item) => PixabayImageItemModel(
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
          return PixabayGridItemWidget(index: index);
        },
      ),
    );
  }
}
