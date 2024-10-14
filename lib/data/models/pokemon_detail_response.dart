import 'package:pokedex/data/models/pokemon_type_response.dart';

class PokemonDetailResponse {
  final int id;
  final String name;
  final String photo;
  final int height;
  final int weight;
  final List<PokemonTypeResponse> types;

  PokemonDetailResponse({
    required this.id,
    required this.name,
    required this.photo,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['sprites']?['front_default'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      types: (json['types'] as List<dynamic>?)
          ?.map((type) => PokemonTypeResponse.fromJson(type))
          .toList() ?? [],
    );
  }
}