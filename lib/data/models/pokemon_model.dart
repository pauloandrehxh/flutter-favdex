class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final int? weight;
  final int? height;
  final int? statusBase;
  final int? hp;
  final int? attack;
  final int? defense;
  final int? spAttack;
  final int? spDefense;
  final int? speed;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.weight,
    this.height,
    this.statusBase,
    this.hp,
    this.attack,
    this.spAttack,
    this.defense,
    this.spDefense,
    this.speed,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    // 1. Tratamento para Listagem Padrão ou Pokedex
    final data = json.containsKey('pokemon_species') ? json['pokemon_species'] : json;
    
    if (data.containsKey('url')) {
      final url = data['url'] as String;
      final urlParts = url.split('/');
      final idStr = urlParts[urlParts.length - 2];
      final id = int.parse(idStr);
      return PokemonModel(
        id: id,
        name: data['name'],
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      );
    }

    // 2. Tratamento para Detalhes Completos
    final listaStats = json['stats'] as List?;
    int? hp, attack, defense, spAttack, spDefense, speed, statusBase;
    
    if (listaStats != null && listaStats.length >= 6) {
      hp = listaStats[0]['base_stat'];
      attack = listaStats[1]['base_stat'];
      defense = listaStats[2]['base_stat'];
      spAttack = listaStats[3]['base_stat'];
      spDefense = listaStats[4]['base_stat'];
      speed = listaStats[5]['base_stat'];
      statusBase = hp! + attack! + defense! + spDefense! + speed! + spAttack!;
    }

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']?['other']?['official-artwork']?['front_default'] ?? '',
      weight: json['weight'],
      height: json['height'],
      hp: hp,
      attack: attack,
      defense: defense,
      spAttack: spAttack,
      spDefense: spDefense,
      speed: speed,
      statusBase: statusBase,
    );
  }
}