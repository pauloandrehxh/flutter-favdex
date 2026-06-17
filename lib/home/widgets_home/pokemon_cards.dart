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
      child: InkWell(
        onTap: () {
          Get.toNamed('/details');
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pokemon.imageUrl != null)
                    Image.network(pokemon.imageUrl!, height: 100),
                  Text('ID: ${pokemon.id}'),
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Peso: ${pokemon.weight}'),
                  Text('Altura: ${pokemon.height}'),
                ],
              ),
            ),

            Positioned(
              bottom: 8,
              right: 8,
              child: Obx(() {
                final isFavorito = controlador.isFavorito(pokemon);
                if (isFavorito) {
                  return IconButton(
                    icon: const Icon(Icons.favorite,
                    color: Colors.red),
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