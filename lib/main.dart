import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:favdex/favdex_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inicializa o armazenamento local
  runApp(const FavDexApp());
}
