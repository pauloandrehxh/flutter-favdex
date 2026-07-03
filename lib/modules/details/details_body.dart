import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:favdex/modules/details/details_controller.dart';

class DetailsBody extends StatelessWidget{
  const DetailsBody ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailsController());
    
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
        title: const Text('Detalhes do Pokémon'),
      ),

      body: Obx(() {
        final pokemon = controller.pokemon.value;
        if (pokemon == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(pokemon.imageUrl, height: 200),
                    Text(
                      pokemon.name.capitalizeFirst ?? pokemon.name,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text('ID: #${pokemon.id.toString().padLeft(3, '0')}', 
                         style: const TextStyle(color: Colors.grey, fontSize: 16)),
                    const SizedBox(height: 24),
                    
                    if (controller.isLoading.value)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      )
                    else if (controller.isError.value)
                      const Text('Erro ao carregar os detalhes do Pokémon.', style: TextStyle(color: Colors.red))
                    else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBox('Peso', '${(pokemon.weight ?? 0) / 10} kg'),
                          _buildInfoBox('Altura', '${(pokemon.height ?? 0) / 10} m'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text('Status Base', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildStatRow('HP', pokemon.hp ?? 0, Colors.green),
                      _buildStatRow('Attack', pokemon.attack ?? 0, Colors.red),
                      _buildStatRow('Defense', pokemon.defense ?? 0, Colors.blue),
                      _buildStatRow('Sp. Atk', pokemon.spAttack ?? 0, Colors.purple),
                      _buildStatRow('Sp. Def', pokemon.spDefense ?? 0, Colors.indigo),
                      _buildStatRow('Speed', pokemon.speed ?? 0, Colors.orange),
                      const SizedBox(height: 16),
                      Text('Total: ${pokemon.statusBase ?? 0}', 
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStatRow(String name, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
          SizedBox(width: 35, child: Text(value.toString(), textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value / 255, // A base máxima de stats de um pokemon comum é por volta de 255
                color: color,
                backgroundColor: color.withOpacity(0.2),
                minHeight: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}