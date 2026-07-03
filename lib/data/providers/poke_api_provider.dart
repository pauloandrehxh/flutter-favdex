import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeApiProvider {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<Map<String, dynamic>> fetchPokemonListFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      final bool isPokedexResponse = dados.containsKey('pokemon_entries');
      
      final String? proximaPagina = isPokedexResponse ? null : dados['next'];
      final List<dynamic> resultadosRaw = isPokedexResponse ? dados['pokemon_entries'] : dados['results'];
      
      final List<PokemonModel> pokemons = resultadosRaw.map((json) => PokemonModel.fromJson(json)).toList();
      
      return {
        'next': proximaPagina,
        'pokemons': pokemons,
      };
    } else {
      throw Exception('Falha ao carregar Pokémon da API');
    }
  }

  Future<PokemonModel> getPokemonDetails(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/${query.toLowerCase()}'));
    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Pokémon não encontrado');
    }
  }
}
