import 'package:pokedex/data/models/pokemon_list_response.dart';
import 'package:pokedex/domain/entities/entities.dart';

class PokemonListMapper {
  static List<PokemonEntry> fromResponse(PokemonListResponse response) {
    return response.results
        .map((item) => PokemonEntry(
              name: item.name,
              url: item.url,
            ))
        .toList();
  }
}