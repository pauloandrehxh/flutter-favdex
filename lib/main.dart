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