import 'package:pokedex/domain/entities/pokemon_type_info.dart';

class PokemonType {
  final int slot;
  final PokemonTypeInfo type;

  PokemonType({
    required this.slot,
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'],
      type: PokemonTypeInfo.fromJson(json['type']),
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }
}