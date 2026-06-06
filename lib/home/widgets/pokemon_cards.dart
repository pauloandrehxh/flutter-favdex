import 'package:flutter/material.dart';
import 'package:favdex/data/models/pokemon_model.dart';

class PokemonCard extends StatelessWidget{
  final PokemonModel pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (pokemon.imageUrl != null)
            Image.network(pokemon.imageUrl!, height: 100),
          Text('ID: ${pokemon.id}'),
          Text(
            pokemon.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Peso: ${pokemon.weight}'),
          Text('Altura: ${pokemon.height}'),
        ],
      ),
    );
  }
}