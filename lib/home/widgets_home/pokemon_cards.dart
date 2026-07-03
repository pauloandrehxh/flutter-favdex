import 'package:flutter/material.dart';
import 'package:favdex/data/models/pokemon_model.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';

class PokemonCard extends StatelessWidget{
  final PokemonModel pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context){
    final controlador = Get.find<HomeControlador>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            '/details',
            arguments: pokemon,
          );
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(pokemon.imageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      pokemon.name.capitalizeFirst ?? pokemon.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Obx(() {
                final isFavorito = controlador.isFavorito(pokemon);
                if (isFavorito) {
                  return IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      controlador.toggleFavorito(pokemon);
                    },
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () { 
                    controlador.toggleFavorito(pokemon);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}