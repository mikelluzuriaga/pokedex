import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/core/errors/app_error.dart';

// Generate a MockDio class
@GenerateMocks([Dio])
import 'pokemon_remote_datasource_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late PokemonRemoteDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = PokemonRemoteDataSource(dio: mockDio);
  });

  group('PokemonRemoteDataSource', () {
    test('getPokemonList should return a list of PokemonEntry', () async {
      final mockResponse = {
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'}
        ]
      };

      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await dataSource.getPokemonList();

      expect(result, isA<List<PokemonEntry>>());
      expect(result.first.name, 'bulbasaur');
    });

    test('getPokemonDetails should return a Pokemon', () async {
      final mockResponse = {
        'id': 1,
        'name': 'bulbasaur',
        'height': 7,
        'weight': 69,
        'types': [
          {
            'slot': 1,
            'type': {'name': 'grass', 'url': 'https://pokeapi.co/api/v2/type/12/'}
          }
        ]
      };

      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await dataSource.getPokemonDetails('https://pokeapi.co/api/v2/pokemon/1/');

      expect(result, isA<Pokemon>());
      expect(result.name, 'bulbasaur');
    });

    test('getPokemonList should throw NetworkError on DioException', () async {
      when(mockDio.get(any)).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => dataSource.getPokemonList(), throwsA(isA<NetworkError>()));
    });

    test('getPokemonDetails should throw NetworkError on DioException', () async {
      when(mockDio.get(any)).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => dataSource.getPokemonDetails('https://pokeapi.co/api/v2/pokemon/1/'), throwsA(isA<NetworkError>()));
    });
  });
}
