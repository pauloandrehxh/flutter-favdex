import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';
import 'pokemon_cards.dart';

class GridPokemonHome extends StatelessWidget {
  const GridPokemonHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<HomeControlador>();

    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount:
            controlador.pokemonList.length +
            (controlador.loadingMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controlador.pokemonList.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final pokemon = controlador.pokemonList[index];

          return PokemonCard(pokemon: pokemon);
        },
      ),
    );
  }
}
