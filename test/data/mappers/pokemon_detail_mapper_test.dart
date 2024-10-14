import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/mappers/pokemon_detail_mapper.dart';
import 'package:pokedex/data/models/pokemon_detail_response.dart';
import 'package:pokedex/data/models/pokemon_type_response.dart';

void main() {
  group('PokemonDetailMapper', () {
    test('fromResponse should map PokemonDetailResponse to Pokemon', () {
      final response = PokemonDetailResponse(
        id: 1,
        name: 'Bulbasaur',
        photo: 'bulbasaur.png',
        height: 7,
        weight: 69,
        types: [
          PokemonTypeResponse(
            slot: 1,
            type: PokemonTypeInfoResponse(name: 'grass', url: 'grass_url'), // Corrected type
          ),
        ],
      );

      final pokemon = PokemonDetailMapper.fromResponse(response);

      expect(pokemon.id, 1);
      expect(pokemon.name, 'Bulbasaur');
      expect(pokemon.photo, 'bulbasaur.png');
      expect(pokemon.height, 7);
      expect(pokemon.weight, 69);
      expect(pokemon.types?.length, 1);
      expect(pokemon.types?.first.slot, 1);
      expect(pokemon.types?.first.type.name, 'grass');
      expect(pokemon.types?.first.type.url, 'grass_url');
      expect(pokemon.isCaptured, false);
    });
  });
}
