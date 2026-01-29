import 'package:flutter/material.dart';
import 'package:gandum_goreng/controllers/controller_dashboard.dart';
import 'package:gandum_goreng/pages/home_page.dart';
import 'package:gandum_goreng/pages/order_page.dart';
import 'package:gandum_goreng/pages/profile_page.dart';
import 'package:get/get.dart';


class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.find<DashboardController>();

  final List<Widget> pages = [
    HomePage(),
    OrderPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: pages[controller.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "List Product"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: "Shop"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ]
      ),
    ),);
  }
}