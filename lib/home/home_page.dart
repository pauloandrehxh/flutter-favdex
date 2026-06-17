import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';
import 'widgets_home/pokemon_grid_home.dart';
import '../app/bottoms.dart';
import 'package:favdex/home/widgets_home/app_bar_home.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.put(HomeControlador(), permanent: true);

    return Scaffold(
      appBar: AppBarHome(),
      body: Obx(() {
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
          child: GridPokemonHome(),
        );
      }),
      bottomNavigationBar: Bottoms(),
    );
  }
}