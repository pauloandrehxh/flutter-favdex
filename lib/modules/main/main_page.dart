import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/modules/main/main_controller.dart';
import 'package:favdex/modules/home/home_page.dart';
import 'package:favdex/modules/favorites/favorite_page.dart';
import 'package:favdex/modules/search/search_page.dart';
import 'package:favdex/core/widgets/pokedex_len.dart';
import 'package:favdex/modules/home/home_controlador.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    final homeController = Get.put(HomeControlador(), permanent: true);

    return Obx(() {
      final currentIndex = controller.currentIndex.value;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 80,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade900, Colors.red.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, offset: Offset(0, 4), blurRadius: 10),
                ],
              ),
            ),
            leadingWidth: 80,
            leading: currentIndex == 0 ? PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'National': homeController.escolhaUrl(0); break;
                  case 'Kanto': homeController.escolhaUrl(1); break;
                  case 'Johto': homeController.escolhaUrl(2); break;
                  case 'Hoenn': homeController.escolhaUrl(3); break;
                  case 'Sinnoh': homeController.escolhaUrl(4); break;
                  case 'Unova': homeController.escolhaUrl(5); break;
                }
              },
              offset: const Offset(60, 60),
              child: const PokedexLen(),
              itemBuilder: (BuildContext context) => const [
                PopupMenuItem(value: 'National', child: Text('National Dex')),
                PopupMenuItem(value: 'Kanto', child: Text('Kanto')),
                PopupMenuItem(value: 'Johto', child: Text('Johto')),
                PopupMenuItem(value: 'Hoenn', child: Text('Hoenn')),
                PopupMenuItem(value: 'Sinnoh', child: Text('Sinnoh')),
                PopupMenuItem(value: 'Unova', child: Text('Unova')),
              ],
            ) : const SizedBox.shrink(),
            title: const Text(
              'FAVDEX',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.black54, offset: Offset(2, 2), blurRadius: 4),
                ],
              ),
            ),
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: const [
            Home(),
            FavoritesPage(),
            SearchPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: controller.changePage,
          selectedItemColor: Colors.red.shade800,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          elevation: 16,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          ],
        ),
      );
    });
  }
}
