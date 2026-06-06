import 'package:get/get.dart';
import 'package:favdex/home/home_page.dart';
import 'package:favdex/favorites/farovite_page.dart';

class AppPages {
  static final pages = [
  GetPage(
    name: '/home', page: () => const Home(),
  ),
  GetPage(
    name: '/favorites', page: () => const FavoritesPage(),
  )];
}