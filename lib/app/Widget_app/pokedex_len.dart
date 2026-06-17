import 'package:flutter/material.dart';

class PokedexLen extends StatelessWidget {
  const PokedexLen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black, // Fundo preto
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 57, // Menor que o preto, para deixar a borda preta visível
          height: 57,
          decoration: BoxDecoration(
            color: Colors.grey.shade300, // Cor do aro (um branco prateado)
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 50, // Menor que o prata, para deixar o aro visível
              height: 50,
              // clipBehavior corta qualquer coisa que tente vazar da lente azul
              clipBehavior: Clip.hardEdge, 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.blue.shade900,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // A bolinha branca (luz)
                  Positioned(
                    top: 6,
                    left: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // Caiu de 0.4 para 0.15 (Bem mais transparente)
                            Colors.white.withOpacity(0.15), 
                            Colors.transparent,
                            // Caiu de 0.1 para 0.05
                            Colors.white.withOpacity(0.05), 
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }  
}