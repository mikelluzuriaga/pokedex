import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex/core/errors/app_error.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// List of all pokemons without details (just name and url)
  /// <br /> First checks local storage, then remote
  @override
  Future<List<PokemonEntry>> getPokemonList() async {
    try {
      List<PokemonEntry> pokemonListEntry = [];
      final localPokemonList = await localDataSource.getPokemons();

      if (localPokemonList.isNotEmpty) {
        pokemonListEntry = localPokemonList;
      } else {
        final remotePokemonListEntries =
            await remoteDataSource.getPokemonList();
        await localDataSource.insertPokemons(remotePokemonListEntries);
        pokemonListEntry = remotePokemonListEntries;
      }

      // Check for local captured pokemons
      final checkedList =
          await localDataSource.checkCapturedPokemons(pokemonListEntry);
      return checkedList;
    } catch (e, stackTrace) {
      if (e is NetworkError) {
        throw NetworkError('Failed to fetch Pokemon list: ${e.message}', stackTrace);
      } else if (e is DatabaseError) {
        throw DatabaseError('Error accessing local Pokemon data: ${e.message}', stackTrace);
      } else {
        throw UnknownError('Unexpected error while fetching Pokemon list: ${e.toString()}', stackTrace);
      }
    }
  }

  /// List of captured pokemons with details
  @override
  Future<List<Pokemon>> getCapturedPokemonList() async {
    try {
      final localPokemonList = await localDataSource.getCapturedPokemons();
      return localPokemonList;
    } catch (e, stackTrace) {
      throw DatabaseError('Failed to get captured Pokemon list: ${e.toString()}', stackTrace);
    }
  }

  /// Get specific pokemon's details
  @override
  Future<Pokemon> getPokemonDetails({
    required String pokemonName,
    required String pokemonUrl,
  }) async {
    try {
      final localPokemonDetail =
          await localDataSource.getPokemonDetails(pokemonName);
      if (localPokemonDetail != null && localPokemonDetail.id != null) {
        // Return if exists in local datasource
        return localPokemonDetail;
      }
      // If doesn't, get from remote
      final remotePokemon =
          await remoteDataSource.getPokemonDetails(pokemonUrl);
      // Save pokemon details in local datasource
      await localDataSource.insertLocalPokemon(remotePokemon);
      return remotePokemon;
    } catch (e, stackTrace) {
      if (e is NetworkError) {
        throw NetworkError('Failed to fetch Pokemon details: ${e.message}', stackTrace);
      } else if (e is DatabaseError) {
        throw DatabaseError('Error accessing local Pokemon details: ${e.message}', stackTrace);
      } else {
        throw UnknownError('Unexpected error while fetching Pokemon details: ${e.toString()}', stackTrace);
      }
    }
  }

  /// Marks a pokemon as captured/released in local storage
  @override
  Future<String> toggleCapturePokemon(Pokemon pokemon) async {
    try {
      return await localDataSource.toggleCapturePokemon(pokemon);
    } catch (e, stackTrace) {
      throw DatabaseError('Failed to toggle capture status: ${e.toString()}', stackTrace);
    }
  }
}