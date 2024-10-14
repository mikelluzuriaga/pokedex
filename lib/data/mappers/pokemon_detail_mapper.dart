import 'package:pokedex/data/models/pokemon_detail_response.dart';
import 'package:pokedex/data/models/pokemon_type_response.dart';
import 'package:pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/domain/entities/pokemon_type.dart';
import 'package:pokedex/domain/entities/pokemon_type_info.dart';

class PokemonDetailMapper {
  static Pokemon fromResponse(PokemonDetailResponse response) {
    return Pokemon(
      id: response.id,
      name: response.name,
      photo: response.photo,
      height: response.height, // Convert decimeters to meters
      weight: response.weight, // Convert hectograms to kilograms
      types: _mapTypes(response.types),
      isCaptured: false, // This information is not available in the response
    );
  }

  static List<PokemonType> _mapTypes(List<PokemonTypeResponse> typeResponses) {
    return typeResponses.map((typeResponse) {
      return PokemonType(
        slot: typeResponse.slot,
        type: PokemonTypeInfo(
          name: typeResponse.type.name,
          url: typeResponse.type.url,
        ),
      );
    }).toList();
  }
}