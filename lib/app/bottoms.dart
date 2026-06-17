import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bottoms extends StatelessWidget {
  const Bottoms({super.key,});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index == 0) {
          Get.toNamed('/home');
        } else if (index == 1) {
          Get.toNamed('/favorites');
        }
      },
      items: const [

        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favoritos',),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Configurações',),
      ],
    );
  }
}