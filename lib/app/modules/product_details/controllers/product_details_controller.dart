import 'package:get/get.dart';

import '../../../data/models/service_model.dart';
import '../../../routes/app_pages.dart';

class ProductDetailsController extends GetxController {
  // get service details from arguments
  ServiceModel product = Get.arguments;

  /// when user press on add to cart button
  onAddToCartPressed() {
    // Navigate to booking page with service details
    Get.toNamed(Routes.BOOKING, arguments: product);
  }
}
