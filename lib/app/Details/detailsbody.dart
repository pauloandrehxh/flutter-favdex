import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/data/models/pokemon_model.dart';

class DetailsBody extends StatelessWidget{
  const DetailsBody ({super.key});

  @override
  Widget build(BuildContext context) {
    final PokemonModel pokemon =  Get.arguments as PokemonModel;
    
    return Scaffold(
      backgroundColor: Colors.red.shade800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade300, Colors.red.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                offset: const Offset(0, 8),
                blurRadius: 18,
             ),
              BoxShadow(
                color: Colors.white.withOpacity(0.08),
                offset: const Offset(0, -3),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      title: Center(
        child: Text('Detalhes'),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 100, bottom: 140),
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(pokemon.imageUrl!),
                Text(pokemon.name),
                Text('ID: ${pokemon.id}'),
                Text('PESO:${pokemon.weight}'),
                Text('ALTURA: ${pokemon.height}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Hp: ${pokemon.hp}'),
                    Text('Attack: ${pokemon.attack}'),
                    Text('Defense: ${pokemon.defense}'),
                    Text('spAttack: ${pokemon.spAttack}'),
                    Text('spDefense: ${pokemon.spDefense}'),
                    Text('Speed: ${pokemon.speed}'),
                  ],
                ),
                Text('StatusBase: ${pokemon.statusBase}'),
              ],
            ),
          ),
        ),
      )
    );
  }
}