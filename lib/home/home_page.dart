import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/home/home_controlador.dart';


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
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount:
                controlador.pokemonList.length +
                (controlador.loadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controlador.pokemonList.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final pokemon = controlador.pokemonList[index];

              return Card(
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
              );
            },
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}