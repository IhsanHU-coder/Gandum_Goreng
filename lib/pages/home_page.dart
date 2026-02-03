import 'package:flutter/material.dart';
import 'package:gandum_goreng/controllers/controller_product.dart';
import 'package:gandum_goreng/pages/mobile/home_page_mobile.dart';
import 'package:gandum_goreng/pages/widescreen/home_page_widescreen.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          controller.updateLayout(constraints);
          return Obx(
            () => controller.isMobile.value
                ? HomePageMobile()
                : HomePageWidescreen(),
          );
        },
      ),
    );
  }
}
