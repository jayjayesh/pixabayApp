// Suggested code may be subject to a license. Learn more: ~LicenseLog:2022858007.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:980123772.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1752391765.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2565976469.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3162804888.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1200432839.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1567601484.
import 'package:flutter/material.dart';
import 'package:myapp/common/service_locator.dart';
import 'package:myapp/features/pixabay/presentation/controller/home_page_state.dart';
import 'package:myapp/features/pixabay/presentation/widgets/pixabay_grid_item_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageState homePageState = serviceLocator<HomePageState>();

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
    return ChangeNotifierProvider<HomePageState>(
      create: (context) => homePageState,
      child: Consumer<HomePageState>(builder: (context, homePageState, child) {
        return Scaffold(
          body: GridView.builder(
            padding: EdgeInsets.only(
              top: homePageState.gridViewItemSpacing,
              left: homePageState.gridViewItemSpacing,
              right: homePageState.gridViewItemSpacing,
              bottom: MediaQuery.of(context).size.height * 0.4,
            ),
            controller: homePageState.scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 190,
              crossAxisSpacing: homePageState.gridViewItemSpacing,
              mainAxisSpacing: homePageState.gridViewItemSpacing,
            ),
            itemCount: homePageState.images.length,
            itemBuilder: (context, index) {
              return PixabayGridItemWidget(
                pixabayImageItemModel: homePageState.images[index],
              );
            },
          ),
        );
      }),
    );
  }
}
