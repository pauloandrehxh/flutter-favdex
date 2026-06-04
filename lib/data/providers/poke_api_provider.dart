import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeApiProvider {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonModel>> fetchPokemonList({int offset = 0, int limit = 20}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
    );
    
    print('\n=====================================');
    print('🟢 CONEXÃO COM A POKEAPI (LISTAGEM)');
    print('URL Chamada: $baseUrl/pokemon?limit=$limit&offset=$offset');
    print('Status: ${response.statusCode}');
    // Limitando o print da resposta para não poluir muito o terminal
    print('Resposta Bruta: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
    print('=====================================\n');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => PokemonModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar Pokémon');
    }
  }

  Future<PokemonModel> getPokemonByNameOrId(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon/${query.toLowerCase()}'),
    );
    
    print('\n=====================================');
    print('🔍 CONEXÃO COM A POKEAPI (BUSCA ESPECÍFICA)');
    print('URL Chamada: $baseUrl/pokemon/${query.toLowerCase()}');
    print('Status: ${response.statusCode}');
    print('Resposta Bruta: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
    print('=====================================\n');

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Pokémon não encontrado');
    }
  }
}
