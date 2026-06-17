import 'package:flutter/material.dart';

class DetailsBody extends StatelessWidget{
  const DetailsBody ({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Center(
          child: Text('Detalhes'),
        ),
      ),

      body: Center(
        child: Text('Detalhes'),
      ),

    );
  }
}