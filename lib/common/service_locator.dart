import 'package:get_it/get_it.dart';
import 'package:myapp/features/pixabay/presentation/controller/home_page_state.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerFactory<HomePageState>(
    () {
      return HomePageState();
    },
  );
}
