import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/domain/usecases/get_pokemon_list.dart';
import 'package:pokedex/data/repositories/pokemon_repository_provider.dart';

part 'get_pokemon_list_uc_provider.g.dart';

@riverpod
GetPokemonList getPokemonListUseCase(GetPokemonListUseCaseRef ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonList(repository);
}