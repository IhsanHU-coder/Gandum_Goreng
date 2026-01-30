import 'package:gandum_goreng/controllers/controller_dashboard.dart';
import 'package:gandum_goreng/controllers/payment_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(),);
    Get.put(PaymentController());

  }

}