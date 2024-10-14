import 'package:pokedex/domain/entities/entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/domain/usecases/get_pokemon_list_uc_provider.dart';

part 'pokemon_list_provider.g.dart';

@riverpod
Future<List<PokemonEntry>> pokemonList(PokemonListRef ref) async {
  final getPokemonList = ref.watch(getPokemonListUseCaseProvider);
  return getPokemonList();
}