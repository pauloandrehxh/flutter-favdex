import 'package:get/get.dart';
import 'package:favdex/data/models/pokemon_model.dart';
import 'package:favdex/data/providers/poke_api_provider.dart';

class HomeControlador extends GetxController {
  final PokeApiProvider provider = PokeApiProvider();

  var pokemonList = <PokemonModel>[].obs;
  var loading = false.obs;
  var favoritos = <int>[].obs;
  var loadingMore = false.obs;
  var favoritosMap = <int, PokemonModel>{}.obs;
  
  var urlList = <String>[
    'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20',
    'https://pokeapi.co/api/v2/pokedex/2/',   /// KANTO
    'https://pokeapi.co/api/v2/pokedex/7/',   /// JOTHO
    'https://pokeapi.co/api/v2/pokedex/15/',
    'https://pokeapi.co/api/v2/pokedex/6/',
    'https://pokeapi.co/api/v2/pokedex/9/',
  ];
  String? urlProximaPagina;
  int urlEscolhida = 0;

  @override
  void onInit() {
    super.onInit();
    urlProximaPagina = urlList[urlEscolhida];
    buscarApi();
  }

  Future<void> buscarApi() async {
    if (urlProximaPagina == null || loadingMore.value) return;

    try {
      if (pokemonList.isEmpty) {
        loading.value = true;
      } else {
        loadingMore.value = true;
      }

      final resposta = await provider.fetchPokemonListFromUrl(urlProximaPagina!);
      
      urlProximaPagina = resposta['next'];
      final novosPokemons = resposta['pokemons'] as List<PokemonModel>;
      
      pokemonList.addAll(novosPokemons);

    } catch (e) {
      print('Erro ao buscar dados: $e');
      Get.snackbar('Erro', 'Falha ao carregar Pokémons.');
    } finally {
      loading.value = false;
      loadingMore.value = false;
    }
  }

  void escolhaUrl(int index) {
    if (urlEscolhida == index) return;
    urlEscolhida = index;
    urlProximaPagina = urlList[urlEscolhida];
    pokemonList.clear();
    buscarApi();
  }

  void toggleFavorito(PokemonModel pokemon) {
    if (favoritosMap.containsKey(pokemon.id)){
      favoritosMap.remove(pokemon.id);
    } else {
      favoritosMap[pokemon.id] = pokemon;
    }
  }

  bool isFavorito(PokemonModel pokemon) {
    return favoritosMap.containsKey(pokemon.id);
  }
}