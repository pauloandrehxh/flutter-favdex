import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/modules/search/search_controller.dart';
import 'package:favdex/modules/home/widgets_home/pokemon_cards.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPokemonController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller.textController,
            decoration: InputDecoration(
              hintText: 'Digite o nome ou ID (ex: 25, pikachu)',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: controller.limparBusca,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onSubmitted: (_) => controller.buscarPokemon(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.buscarPokemon,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Buscar'),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final pokemon = controller.pokemonEncontrado.value;
              if (pokemon == null) {
                return const Center(
                  child: Text(
                    'Busque por um Pokémon para ver os detalhes.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return Center(
                child: SizedBox(
                  height: 250,
                  width: 200,
                  child: PokemonCard(pokemon: pokemon),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
