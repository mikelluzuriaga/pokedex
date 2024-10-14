import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class ToggleCapturePokemon {
  final PokemonRepository repository;

  ToggleCapturePokemon(this.repository);

  Future<String> call(Pokemon pokemon) async {
    return await repository.toggleCapturePokemon(pokemon);
  }
}