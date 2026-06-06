import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';
import 'widgets/pokemon_grid_home.dart';
import 'widgets/bottoms.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.put(Controlador());

    return Scaffold(
      appBar: AppBar(title: const Text('FavDex')),
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