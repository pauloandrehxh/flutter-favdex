import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:favdex/data/models/pokemon_model.dart';




class Controlador extends GetxController {
  var pokemonList = <PokemonModel>[].obs;
  var loading = false.obs;

  // 1. Variável que faltava declarar!
  var loadingMore = false.obs;

  String? urlProximaPagina =
      'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20';

  @override
  void onInit() {
    super.onInit();
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

        urlProximaPagina = dados['next'];

        final List<dynamic> resultados = dados['results'];

        List<Future<http.Response>> chamadasPendentes = [];
        for (var pokemon in resultados) {
          final uriPokemon = Uri.parse(pokemon['url']);
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
}