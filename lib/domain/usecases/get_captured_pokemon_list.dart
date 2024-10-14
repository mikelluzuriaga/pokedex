import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetCapturedPokemonList {
  final PokemonRepository repository;

  GetCapturedPokemonList(this.repository);

  Future<List<Pokemon>> call() async {
    return await repository.getCapturedPokemonList();
  }
}