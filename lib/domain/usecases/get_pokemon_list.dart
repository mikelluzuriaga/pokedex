import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<PokemonEntry>> call() async {
    return await repository.getPokemonList();
  }
}