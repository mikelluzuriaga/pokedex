import 'package:pokedex/domain/usecases/toggle_capture_pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/data/repositories/pokemon_repository_provider.dart';

part 'toggle_captured_pokemon_uc_provider.g.dart';

@riverpod
ToggleCapturePokemon toggleCapturePokemonUc(ToggleCapturePokemonUcRef ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return ToggleCapturePokemon(repository);
}