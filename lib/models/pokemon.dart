import 'dart:convert';

Pokemon pokemonFromJson(String? str) => Pokemon.fromJson(json.decode(str!));

class Pokemon {
  Pokemon({
    this.pokemon,
  });

  List<PokemonElement>? pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        pokemon: List<PokemonElement>.from(
            json["pokemon"].map((x) => PokemonElement.fromJson(x))),
      );
}

class PokemonElement {
  PokemonElement({
    this.id,
    this.number,
    this.name,
    this.img,
    this.type,
    this.height,
    this.weight,
    this.candy,
    this.candyCount,
    this.egg,
    this.spawnChance,
    this.avgSpawns,
    this.spawnTime,
    this.multipliers,
    this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  int? id;
  String? number;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  int? candyCount;
  String? egg;
  double? spawnChance;
  double? avgSpawns;
  String? spawnTime;
  List<double>? multipliers;
  List<String>? weaknesses;
  List<Evolution>? nextEvolution;
  List<Evolution>? prevEvolution;

  factory PokemonElement.fromJson(Map<String, dynamic> json) => PokemonElement(
        id: json["id"],
        number: json["num"],
        name: json["name"],
        img: json["img"],
        type: List<String>.from(json["type"].map((x) => x)),
        height: json["height"],
        weight: json["weight"],
        candy: json["candy"],
        candyCount: json["candy_count"] == null ? null : json["candy_count"],
        egg: json["egg"],
        spawnChance: json["spawn_chance"].toDouble(),
        avgSpawns: json["avg_spawns"].toDouble(),
        spawnTime: json["spawn_time"],
        multipliers: json["multipliers"] == null
            ? null
            : List<double>.from(json["multipliers"].map((x) => x.toDouble())),
        weaknesses: List<String>.from(json["weaknesses"].map((x) => x)),
        nextEvolution: json["next_evolution"] == null
            ? null
            : List<Evolution>.from(
                json["next_evolution"].map((x) => Evolution.fromJson(x))),
        prevEvolution: json["prev_evolution"] == null
            ? null
            : List<Evolution>.from(
                json["prev_evolution"].map((x) => Evolution.fromJson(x))),
      );
}

class Evolution {
  Evolution({
    this.number,
    this.nameLevel,
  });

  String? number;
  String? nameLevel;

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        number: json["num"],
        nameLevel: json["name"],
      );
}
