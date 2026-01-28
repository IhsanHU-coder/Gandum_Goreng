import 'package:gandum_goreng/pages/home_page.dart';
import 'package:gandum_goreng/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home, 
      page: () => HomePage()
      )
  ];
}