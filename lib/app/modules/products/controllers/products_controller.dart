import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/service_model.dart';

class ProductsController extends GetxController {

  // to hold services
  List<ServiceModel> services = [];

  @override
  void onInit() {
    getServices();
    super.onInit();
  }

  /// get services from dummy helper
  getServices() {
    services.addAll(DummyHelper.services);
    services.removeWhere((s) => s.id == 2);
  }
}
