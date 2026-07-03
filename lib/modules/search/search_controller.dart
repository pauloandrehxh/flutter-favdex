import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/data/models/pokemon_model.dart';
import 'package:favdex/data/providers/poke_api_provider.dart';

class SearchPokemonController extends GetxController {
  final PokeApiProvider provider = PokeApiProvider();
  final textController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var pokemonEncontrado = Rxn<PokemonModel>();

  void buscarPokemon() async {
    final query = textController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    isLoading.value = true;
    errorMessage.value = '';
    pokemonEncontrado.value = null;

    try {
      final result = await provider.getPokemonDetails(query);
      pokemonEncontrado.value = result;
    } catch (e) {
      errorMessage.value = 'Pokémon não encontrado. Verifique o nome ou ID.';
    } finally {
      isLoading.value = false;
    }
  }

  void limparBusca() {
    textController.clear();
    pokemonEncontrado.value = null;
    errorMessage.value = '';
  }
}
