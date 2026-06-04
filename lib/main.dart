import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

void main() async {
  await GetStorage.init(); // Inicializa o armazenamento local
  runApp(const FavDexApp());
}

class FavDexApp extends StatelessWidget {
  const FavDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FavDex',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const Home()),
      ]
    );
  }
}




class AppPages{
  static final pages =[
    GetPage(
      name: '/home', 
      page: () => const Home()
    ),
  ];
}


class Home extends StatelessWidget{
  const Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FavDex')),
      body: Center(child: Text('Home do FavDex')),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}



class Controlador extends GetxController {
  var pokemonList = <PokemonModel>[].obs;
  var loading = false.obs;
  
  // 1. Variável que faltava declarar!
  var loadingMore = false.obs; 

  String? urlProximaPagina = 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20';

  @override
  void onInit() {
    super.onInit();
    buscarApi();
  }

  Future<void> buscarApi() async { 
    if (urlProximaPagina == null || loadingMore.value) return;

    try {

      if (pokemonList.isEmpty){ 
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
      loadingMore.value = false; //
    }
  }
}






class PokemonModel{
  final int id; 
  final String name;
  final String? imageUrl;
  final int? weight;
  final int? height;

  PokemonModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.weight,
    this.height,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> resultado){
    return PokemonModel(
      id: resultado['id'],
      name: resultado['name'],
      imageUrl: resultado['sprites']['other']['official-artwork']['front_default'],
      weight: resultado['weight'],
      height: resultado['height'],
    );
  }
}
