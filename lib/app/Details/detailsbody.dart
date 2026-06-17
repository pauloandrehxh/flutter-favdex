import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/data/models/pokemon_model.dart';

class DetailsBody extends StatelessWidget{
  const DetailsBody ({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonModel pokemon =  Get.arguments as PokemonModel;
    
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Detalhes'),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Image.network(pokemon.imageUrl!),
            Text(pokemon.name),
            Text('${pokemon.id}'),
            Text('${pokemon.weight}'),
            Text('${pokemon.height}'),
          ],
        ),
      )
    );
  }
}