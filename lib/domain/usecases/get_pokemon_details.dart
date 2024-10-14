import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails(this.repository);

  Future<Pokemon> call(PokemonEntry pokemon) async {
    return await repository.getPokemonDetails(
      pokemonName: pokemon.name,
      pokemonUrl: pokemon.url,
    );
  }
}