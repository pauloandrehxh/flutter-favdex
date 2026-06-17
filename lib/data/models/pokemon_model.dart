class PokemonModel {
  final int id;
  final String name;
  final String? imageUrl;
  final int? weight;
  final int? height;

  PokemonModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.weight,
    this.height,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> resultado) {
    return PokemonModel(
      id: resultado['id'],
      name: resultado['name'],
      imageUrl:
          resultado['sprites']['other']['official-artwork']['front_default'],
      weight: resultado['weight'],
      height: resultado['height'],
    );
  }
}