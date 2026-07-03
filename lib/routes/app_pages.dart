import 'package:get/get.dart';
import 'package:favdex/modules/main/main_page.dart';
import 'package:favdex/modules/home/home_page.dart';
import 'package:favdex/modules/favorites/favorite_page.dart';
import 'package:favdex/modules/details/details_page.dart';
import 'package:favdex/modules/search/search_page.dart';

class AppPages {
  static final pages = [
  GetPage(
    name: '/main', page: () => const MainPage(),
  ),
  GetPage(
    name: '/home', page: () => const Home(),
  ),
  GetPage(
    name: '/favorites', page: () => const FavoritesPage(),
  ),
  GetPage(
    name: '/details', page: () => const DetailsPage(),
  ),
  GetPage(
    name: '/search', page: () => const SearchPage(),
  )];
}