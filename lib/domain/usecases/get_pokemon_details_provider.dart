import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/data/repositories/pokemon_repository_provider.dart';

part 'get_pokemon_details_provider.g.dart';

@riverpod
Future<Pokemon> getPokemonDetails(
  GetPokemonDetailsRef ref, {
  required String pokemonName,
  required String pokemonUrl,
}) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonDetails(
    pokemonName: pokemonName,
    pokemonUrl: pokemonUrl,
  );
}