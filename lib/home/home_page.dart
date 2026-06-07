import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';
import 'widgets_home/pokemon_grid_home.dart';
import '../app/bottoms.dart';
import '../app/Widget_app/pokedex_len.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.put(HomeControlador(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80, 
        toolbarHeight: 80,
        leading: PopupMenuButton(
          offset: Offset(60, 60),
          child: const PokedexLen(),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'geracao',
              child: Text('Filtrar por Geração'),
            ),
          ],
        ),
        centerTitle: true,
        title: const Text('FavDex'),
      ),

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