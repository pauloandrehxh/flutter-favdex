import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/app/app_pages.dart';


class FavDexApp extends StatelessWidget {
  const FavDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FavDex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: AppPages.pages,
    );
  }
}