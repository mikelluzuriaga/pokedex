import 'package:dio/dio.dart';
import 'package:pokedex/core/constants/constants.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:pokedex/data/mappers/pokemon_detail_mapper.dart';
import 'package:pokedex/data/mappers/pokemon_list_mapper.dart';
import 'package:pokedex/data/models/pokemon_detail_response.dart';
import 'package:pokedex/data/models/pokemon_list_response.dart';
import 'package:pokedex/domain/entities/entities.dart';

class PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource({required this.dio});

  Future<List<PokemonEntry>> getPokemonList() async {
    try {
      final response = await dio.get('${Constants.baseUrl}/pokemon/?limit=151');
      final pokemonListResponse = PokemonListResponse.fromJson(response.data);
      final pokemons = PokemonListMapper.fromResponse(pokemonListResponse);
      return pokemons;
    } on DioException catch (e) {
      throw NetworkError('Failed to fetch Pokemon list: ${e.message}');
    } catch (e) {
      throw UnknownError(
          'Unexpected error while fetching Pokemon list: ${e.toString()}');
    }
  }

  Future<Pokemon> getPokemonDetails(String pokemonUrl) async {
    try {
      final response = await dio.get(pokemonUrl);
      final pokemonDetailResponse =
          PokemonDetailResponse.fromJson(response.data);
      Pokemon pokemon = PokemonDetailMapper.fromResponse(pokemonDetailResponse);
      pokemon = pokemon.copyWith(url: pokemonUrl);
      return pokemon;
    } on DioException catch (e) {
      throw NetworkError('Failed to fetch Pokemon details: ${e.message}');
    } catch (e) {
      throw UnknownError(
          'Unexpected error while fetching Pokemon details: ${e.toString()}');
    }
  }
}