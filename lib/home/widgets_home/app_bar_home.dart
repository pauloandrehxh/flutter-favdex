import 'package:flutter/material.dart';
import 'package:favdex/app/Widget_app/pokedex_len.dart';


class AppBarHome extends StatelessWidget implements PreferredSizeWidget{
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80, 
      toolbarHeight: 80,
      leading: PopupMenuButton(
        offset: Offset(60, 60),
        child: const PokedexLen(),
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem<String>(
            value: 'geracao',
            child: Text('Filtrar por Geração'),
          ),
        ],
      ),
      centerTitle: true,
      title: const Text('FavDex'),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(80);
}