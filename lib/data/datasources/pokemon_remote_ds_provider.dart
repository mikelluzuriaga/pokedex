import 'package:pokedex/data/services/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';

part 'pokemon_remote_ds_provider.g.dart';

@riverpod
PokemonRemoteDataSource pokemonRemoteDataSource(PokemonRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return PokemonRemoteDataSource(dio: dio);
}