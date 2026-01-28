import 'package:flutter/material.dart';
import 'package:gandum_goreng/routes/pages.dart';
import 'package:gandum_goreng/routes/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages ,
    );
  }
}