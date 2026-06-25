import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';



class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritosControlador = Get.find<HomeControlador>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FavDex')
        
      ),
      body: Obx(() {

        final pokemonsFavoritos = favoritosControlador.favoritosMap.values.toList();

        if (pokemonsFavoritos.isEmpty) {
          return const Center(child: Text('Nenhum Pokémon favorito encontrado.'));
        }

        return ListView.builder(
          itemCount: pokemonsFavoritos.length,
          itemBuilder: (context, index) {
            final pokemon = pokemonsFavoritos[index];
            Widget imagem;
              if (pokemon.imageUrl != null) {
                imagem = Image.network(
                  pokemon.imageUrl!,
                  height: 56,
                  width: 56,
                );
              } 
              else {
                imagem = const Icon(Icons.image_not_supported);
              }

              return Card(
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      'details',
                      arguments: pokemon,
                    );
                  },
                  leading: imagem,
                  title: Text(pokemon.name),
                ),
              );
          },
        );
      }),
    );
  }
}