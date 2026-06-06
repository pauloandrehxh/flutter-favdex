import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_page.dart';


class FavDexApp extends StatelessWidget {
  const FavDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FavDex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [GetPage(name: '/home', page: () => const Home())],
    );
  }
}