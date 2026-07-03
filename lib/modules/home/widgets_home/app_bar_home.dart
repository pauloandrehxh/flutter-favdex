import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/core/widgets/pokedex_len.dart';
import 'package:favdex/modules/home/home_controlador.dart';




class AppBarHome extends StatelessWidget implements PreferredSizeWidget{
  const AppBarHome({super.key,});


  @override
  Widget build(BuildContext context) {
    final controlador = Get.find<HomeControlador>();
    return AppBar(
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
      leadingWidth: 80, 
      leading: PopupMenuButton(
        onSelected: (index) {
          switch (index) {
            case 'National':
              controlador.escolhaUrl(0);
              break;
            case 'Kanto':
              controlador.escolhaUrl(1);
              break;
            case 'Johto':
              controlador.escolhaUrl(2);
              break;
            case 'Hoenn':
              controlador.escolhaUrl(3);
              break;
            case 'Sinnoh':
              controlador.escolhaUrl(4);
              break;
            case 'Unova':
              controlador.escolhaUrl(5);
              break;
          }
        },
        offset: Offset(60, 60),
        child: const PokedexLen(),
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem<String>(
            value: 'National',
            child: Text('National Dex'),
          ),
          const PopupMenuItem<String>(
            value: 'Kanto',
            child: Text('Pokemons de Kanto'),
          ),
          const PopupMenuItem<String>(
            value: 'Johto',
            child: Text('Pokemons de Johto'),

          ),
          const PopupMenuItem<String>(
            value: 'Hoenn',
            child: Text('Pokemons de Hoenn'),
          ),
          const PopupMenuItem<String>(
            value: 'Sinnoh',
            child: Text('Pokemons de Sinnoh'),
          ),
          const PopupMenuItem<String>(
            value: 'Unova',
            child: Text('Pokemons de Unova'),
          ),
        ],
      ),
      title: const Text('FavDex'),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(80);
}