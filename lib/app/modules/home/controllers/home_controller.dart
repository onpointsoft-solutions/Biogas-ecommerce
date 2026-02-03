import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/service_model.dart';

class HomeController extends GetxController {

  // to hold categories & services
  List<CategoryModel> categories = [];
  List<ServiceModel> services = [];

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for home screen cards
  var cards = DummyHelper.cards;

  @override
  void onInit() {
    getCategories();
    getServices();
    super.onInit();
  }

  /// get categories from dummy helper
  getCategories() {
    categories = DummyHelper.categories;
  }

  /// get services from dummy helper
  getServices() {
    services = DummyHelper.services;
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
  
}
