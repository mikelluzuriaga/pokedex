import 'package:pokedex/domain/entities/entities.dart';

abstract class PokemonRepository {
  Future<List<PokemonEntry>> getPokemonList();
  Future<List<Pokemon>> getCapturedPokemonList();
  Future<Pokemon> getPokemonDetails({
    required String pokemonName,
    required String pokemonUrl,
  });
  Future<String> toggleCapturePokemon(Pokemon pokemon);
}