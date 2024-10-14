import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/usecases/get_captured_pokemon_list_uc_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'captured_pokemon_list_provider.g.dart';

@riverpod
Future<List<Pokemon>> capturedPokemonList(CapturedPokemonListRef ref) async {
  final getCapturedPokemonList = ref.watch(getCapturedPokemonListUcProvider);
  return getCapturedPokemonList();
}