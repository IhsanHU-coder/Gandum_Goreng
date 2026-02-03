import 'package:flutter/widgets.dart';
import 'package:gandum_goreng/bindings/dashboard_binding.dart';
import 'package:gandum_goreng/pages/dashboard_page.dart';
import 'package:gandum_goreng/pages/home_page.dart';
import 'package:gandum_goreng/routes/routes.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final pages = [
    // GetPage(name: AppRoutes.home, page: () => HomePage()),
    GetPage(
      name: AppRoutes.dashboard, 
      page: () => DashboardPage(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: AppRoutes.homepage,
      page: () => HomePage(),
      binding: DashboardBinding(),
    ),
  ];
}