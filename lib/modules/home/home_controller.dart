import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/providers/poke_api_provider.dart';

class HomeController extends GetxController {
  final PokeApiProvider provider;
  HomeController(this.provider);

  var pokemons = <PokemonModel>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var isSearchLoading = false.obs;
  var hasReachedMax = false.obs;
  
  int _offset = 0;
  final int _limit = 20;

  final searchController = TextEditingController();
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
    
    searchController.addListener(() {
      searchText.value = searchController.text;
    });

    debounce(
      searchText,
      _performSearch,
      time: const Duration(milliseconds: 800),
    );
  }

  Future<void> fetchPokemons() async {
    if (isLoading.value || hasReachedMax.value || searchText.value.isNotEmpty) return;
    isLoading.value = true;
    isError.value = false;
    try {
      final newPokemons = await provider.fetchPokemonList(offset: _offset, limit: _limit);
      if (newPokemons.isEmpty) {
        hasReachedMax.value = true;
      } else {
        _offset += _limit;
        pokemons.addAll(newPokemons);
      }
    } catch (e) {
      isError.value = true;
      Get.snackbar('Erro', 'Falha ao carregar Pokémon.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }
    isSearchLoading.value = true;
    try {
      final result = await provider.getPokemonByNameOrId(query.trim());
      pokemons.clear();
      pokemons.add(result);
      hasReachedMax.value = true;
    } catch (e) {
      pokemons.clear();
      Get.snackbar('Não encontrado', 'Não conseguimos encontrar esse Pokémon.', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSearchLoading.value = false;
    }
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    pokemons.clear();
    _offset = 0;
    hasReachedMax.value = false;
    fetchPokemons();
  }
}
