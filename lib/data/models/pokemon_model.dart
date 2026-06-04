class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String>? types;
  final int? height;
  final int? weight;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types,
    this.height,
    this.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    // Tratamento para quando vem da listagem (tem apenas name e url)
    if (json.containsKey('url')) {
      final url = json['url'] as String;
      final urlParts = url.split('/');
      final idStr = urlParts[urlParts.length - 2];
      final id = int.parse(idStr);
      return PokemonModel(
        id: id,
        name: json['name'],
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      );
    }

    // Tratamento para detalhes do Pokemon
    final typesList = json['types'] as List?;
    final types =
        typesList?.map((t) => t['type']['name'] as String).toList();

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']
              ['front_default'] ??
          json['sprites']['front_default'],
      types: types,
      height: json['height'],
      weight: json['weight'],
    );
  }
}
