import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/data/datasources/pokemon_remote_ds_provider.dart';
import 'package:pokedex/data/datasources/pokemon_local_ds_provider.dart';

part 'pokemon_repository_provider.g.dart';

@riverpod
PokemonRepositoryImpl pokemonRepository(PokemonRepositoryRef ref) {
  final remoteDataSource = ref.watch(pokemonRemoteDataSourceProvider);
  final localDataSource = ref.watch(pokemonLocalDataSourceProvider);
  return PokemonRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}