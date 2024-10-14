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
  late int _gridviewCount;

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
              );
            },
          ),
        );
      }),
    );
  }
}
