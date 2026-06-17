import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:favdex/data/models/pokemon_model.dart';




class HomeControlador extends GetxController {
  var pokemonList = <PokemonModel>[].obs;
  var loading = false.obs;
  var favoritos = <int>[].obs;
  var loadingMore = false.obs;
  var favoritosMap = <int, PokemonModel>{}.obs;
  var urlList = <String>[
    'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20',
    'https://pokeapi.co/api/v2/pokedex/2/',   ///["pokemon_entries"][id]["pokemon_species"]["name"]  KANTO
    'https://pokeapi.co/api/v2/pokedex/7/',   ///["pokemon_entries"][id]["pokemon_species"]["name"]  JOTHO
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
      }
      loadingMore.value = true;

      final uri = Uri.parse(urlProximaPagina!);
      final resposta = await http.get(uri);

      if (resposta.statusCode == 200) {
        final Map<String, dynamic> dados = jsonDecode(resposta.body);

        final bool isPokedexResponse = dados.containsKey('pokemon_entries');
        urlProximaPagina = isPokedexResponse ? null : dados['next'];

        final List<dynamic> resultados = isPokedexResponse
            ? dados['pokemon_entries']
            : dados['results'];

        List<Future<http.Response>> chamadasPendentes = [];
        for (var item in resultados) {
          Uri uriPokemon;
          if (isPokedexResponse) {
            final species = item['pokemon_species'];
            final String nome = species['name'];
            uriPokemon = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nome');
          } else {
            uriPokemon = Uri.parse(item['url']);
          }
          chamadasPendentes.add(http.get(uriPokemon));
        }

        final respostas = await Future.wait(chamadasPendentes);

        for (var respostaPokemon in respostas) {
          if (respostaPokemon.statusCode == 200) {
            final dadosPokemon = jsonDecode(respostaPokemon.body);
            pokemonList.add(PokemonModel.fromJson(dadosPokemon));
          }
        }
      } else {
        print('Erro na resposta: ${resposta.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    } finally {
      loading.value = false;
      loadingMore.value = false;
    }
  }


  void escolhaUrl(int index) {
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