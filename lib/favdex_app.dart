import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/routes/app_pages.dart';


class FavDexApp extends StatelessWidget {
  const FavDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FavDex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      getPages: AppPages.pages,
    );
  }
}