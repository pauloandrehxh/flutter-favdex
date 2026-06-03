import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const Scaffold(
        body: Center(child: Text('FavDex Iniciado')),
      ),
    );
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
      imageUrl: resultado['sprites']['front_default'],
      weight: resultado['weight'],
      height: resultado['height'],
    );
  }
}