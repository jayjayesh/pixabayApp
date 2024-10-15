import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/models/pixabay_image_item_model.dart';
import 'package:myapp/common/service_locator.dart';
import 'package:myapp/features/pixabay/presentation/controller/home_page_state.dart';
import 'package:myapp/features/pixabay/presentation/widgets/pixabay_grid_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageState homePageState = serviceLocator<HomePageState>();
  late int _gridviewCount;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    homePageState.fetchImages();
    homePageState.scrollController.addListener(homePageState.scrollListener);
  }

  @override
  void dispose() {
    homePageState.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var divider = MediaQuery.of(context).size.width / 210;
    // Check if devider has fractional over 0.8
    // NOTE : We could use divider.roundof() instead this custome solution
    if (divider - divider.floorToDouble() > 0.9) {
      _gridviewCount = divider.ceilToDouble().toInt();
    } else {
      _gridviewCount = divider.floorToDouble().toInt();
    }

    return ChangeNotifierProvider<HomePageState>(
      create: (context) => homePageState,
      child: Consumer<HomePageState>(builder: (context, homePageState, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: homePageState.searchImageQueryList.map((item) {
                    return IconButton(
                      onPressed: () {
                        homePageState.setSearchImageQuery(item.value);
                      },
                      icon: Text(
                        item.title,
                        style: TextStyle(
                          color: homePageState.searchImageQuery == item.value
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          body: GridView.builder(
            padding: EdgeInsets.only(
              top: homePageState.gridViewItemSpacing,
              left: homePageState.gridViewItemSpacing,
              right: homePageState.gridViewItemSpacing,
              bottom: MediaQuery.of(context).size.height *
                  0.4, // to allow desktop room to load next page
            ),
            controller: homePageState.scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridviewCount,
              // crossAxisCount: MediaQuery.of(context).size.width ~/ 210,
              crossAxisSpacing: homePageState.gridViewItemSpacing,
              mainAxisSpacing: homePageState.gridViewItemSpacing,
            ),
            itemCount: homePageState.images.length,
            itemBuilder: (context, index) {
              return PixabayGridItemWidget(
                pixabayImageItemModel: homePageState.images[index],
                onTapPreviewImage: () {
                  onTapPreviewImage(
                      context: context,
                      pixabayImageItemModel: homePageState.images[index]);
                },
              );
            },
          ),
        );
      }),
    );
  }

  void onTapPreviewImage(
      {required BuildContext context,
      required PixabayImageItemModel pixabayImageItemModel}) {
    final popupWidgetSize =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.height * 0.9;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        // or any desired positioning
        child: GestureDetector(
          onTap: () {
            _hideInteractiveViewerPopup();
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: InteractiveViewer(
                clipBehavior: Clip.none, // to zoom and fill all screen
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: popupWidgetSize,
                  height: popupWidgetSize,
                  imageUrl: pixabayImageItemModel.imageUrlLarge,
                  // To remove placeholder to downloaded large image transition
                  fadeInDuration: const Duration(milliseconds: 10),
                  // fadeOutDuration: const Duration(milliseconds: 10),
                  placeholder: (context, url) {
                    return Skeletonizer(
                      enabled: true,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: popupWidgetSize,
                        height: popupWidgetSize,
                        imageUrl: pixabayImageItemModel.imageUrlPreview,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                        child: Icon(
                      Icons.broken_image,
                      size: 200,
                    ));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    /// show overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideInteractiveViewerPopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
