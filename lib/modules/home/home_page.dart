import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/modules/home/home_controlador.dart';
import 'widgets_home/pokemon_grid_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<HomeControlador>();

    return Obx(() {
      if (controlador.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels >=
              scrollNotification.metrics.maxScrollExtent - 200) {
            controlador.buscarApi();
          }
          return false;
        },
        child: const GridPokemonHome(),
      );
    });
  }
}