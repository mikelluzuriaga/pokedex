import 'package:pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_local_ds_provider.g.dart';

@riverpod
PokemonLocalDataSource pokemonLocalDataSource(PokemonLocalDataSourceRef ref){
  return PokemonLocalDataSource();
} 