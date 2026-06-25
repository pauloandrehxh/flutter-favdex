class PokemonModel {
  final int id;
  final String name;
  final String? imageUrl;
  final int? weight;
  final int? height;
  final int statusBase;
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

  PokemonModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.weight,
    this.height,
    required this.statusBase,
    required this.hp,
    required this.attack,
    required this.spAttack,
    required this.defense,
    required this.spDefense,
    required this.speed,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> resultado) {

    final listaStats = resultado['stats'] as List;
    
    final int hp = listaStats[0]['base_stat'];
    final int attack = listaStats[1]['base_stat'];
    final int defense = listaStats[2]['base_stat'];
    final int spAttack = listaStats[3]['base_stat'];
    final int spDefense = listaStats[4]['base_stat'];
    final int speed = listaStats[5]['base_stat'];

    return PokemonModel(
      id: resultado['id'],
      name: resultado['name'],
      imageUrl:
          resultado['sprites']['other']['official-artwork']['front_default'],
      weight: resultado['weight'],
      height: resultado['height'],
      hp: hp,
      attack: attack,
      defense: defense,
      spAttack: spAttack,
      spDefense: spDefense,
      speed: speed,
      statusBase: hp + attack + defense + spDefense + speed + spAttack,
    );
  }
}