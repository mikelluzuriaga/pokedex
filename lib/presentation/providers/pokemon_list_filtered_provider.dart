import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/presentation/providers/home/pokemon_list_filter_provider.dart';
import 'package:pokedex/presentation/providers/pokemon_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list_filtered_provider.g.dart';

@riverpod
Future<List<PokemonEntry>> pokemonListFiltered(PokemonListFilteredRef ref) async {
  final filter = ref.watch(pokemonListFilterProvider);
  final pokemonList = await ref.watch(pokemonListProvider.future);
  
  if (filter.isEmpty) {
    return pokemonList;
  }
  
  return pokemonList.where((pokemon) => 
    pokemon.name.toLowerCase().contains(filter)
  ).toList();
}