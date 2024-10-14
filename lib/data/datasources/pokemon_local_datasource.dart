import 'package:pokedex/core/constants/constants.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:pokedex/data/services/preferences/key_value_storage_service_impl.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:sembast/sembast.dart';
import 'package:pokedex/data/services/sembast/sembast_db_service.dart';

class PokemonLocalDataSource {
  static const String pokemonFolder = "pokemonList";
  static const String capturedFolder = "pokemonDetails";
  final _pokemonFolder = intMapStoreFactory.store(pokemonFolder);
  final _pokemonDetailsFolder = intMapStoreFactory.store(capturedFolder);

  Future<Database> get _db async => await SembastDbService().database;

  /// Store the pokemonEntries in local store
  Future<void> insertPokemons(List<PokemonEntry> pokemonEntries) async {
    try {
      final List<Map<String, dynamic>> pokemonEntriesMaps =
          pokemonEntries.map((pokemonEntry) => pokemonEntry.toJson()).toList();
      await _pokemonFolder.addAll(await _db, pokemonEntriesMaps);
    } catch (e) {
      throw DatabaseError('Failed to insert Pokemons: ${e.toString()}');
    }
  }

  /// List of pokemons (name and url, without details)
  Future<List<PokemonEntry>> getPokemons() async {
    try {
      final recordSnapshots = await _pokemonFolder.find(await _db);
      return recordSnapshots.map((snapshot) {
        return PokemonEntry.fromJson(snapshot.value);
      }).toList();
    } catch (e) {
      throw DatabaseError('Failed to get Pokemons: ${e.toString()}');
    }
  }

  /// List of all captured pokemon (with details)
  Future<List<Pokemon>> getCapturedPokemons() async {
    try {
      final finder = Finder(filter: Filter.equals('isCaptured', true));
      final recordSnapshots =
          await _pokemonDetailsFolder.find(await _db, finder: finder);
      return recordSnapshots.map((snapshot) {
        return Pokemon.fromJson(snapshot.value);
      }).toList();
    } catch (e) {
      throw DatabaseError('Failed to get captured Pokemons: ${e.toString()}');
    }
  }

  /// Get the details of a specific pokemon
  Future<Pokemon?> getPokemonDetails(String pokemonName) async {
    try {
      final finder = Finder(filter: Filter.equals('name', pokemonName));
      final recordSnapshot =
          await _pokemonDetailsFolder.findFirst(await _db, finder: finder);
      if (recordSnapshot != null) {
        return Pokemon.fromJson(recordSnapshot.value);
      }
      return null;
    } catch (e) {
      throw DatabaseError('Failed to get Pokemon details: ${e.toString()}');
    }
  }

  /// Insert a new pokemon in pokemon with details store
  Future<void> insertLocalPokemon(Pokemon pokemon) async {
    try {
      await _pokemonDetailsFolder.add(await _db, pokemon.toJson());
    } catch (e) {
      throw DatabaseError('Failed to insert local Pokemon: ${e.toString()}');
    }
  }

  /// Checks if the pokemon is saved in the local storage
  /// and updates it's isCaptured property to !isCaptured
  /// <br />Calls calculateCapturedPokemons() at the end and
  /// records it's return value to shared preferences
  Future<String> toggleCapturePokemon(Pokemon pokemon) async {
    try {
      final pokemonUpdated = pokemon.copyWith(isCaptured: !pokemon.isCaptured);
      final finder = Finder(filter: Filter.equals('name', pokemon.name));
      final recordSnapshot =
          await _pokemonDetailsFolder.findFirst(await _db, finder: finder);
      if (recordSnapshot != null) {
        final record = _pokemonDetailsFolder.record(recordSnapshot.key);
        await record.update(await _db, pokemonUpdated.toJson());
      } else {
        await insertLocalPokemon(pokemonUpdated);
      }
      final type = await calculateCapturedPokemons();
      final keyValueStorageService = KeyValueStorageServiceImpl();
      await keyValueStorageService.setKeyValue(Constants.mostRepeatedType, type);
      return type;
    } catch (e) {
      throw DatabaseError('Failed to toggle capture Pokemon: ${e.toString()}');
    }
  }

  /// Calculates the types of captured Pokémon and their counts
  /// <br /> It returns a String, which is the type with more counts, or '' if tie
  Future<String> calculateCapturedPokemons() async {
    try {
      final finder = Finder(filter: Filter.equals('isCaptured', true));
      final recordSnapshot =
          await _pokemonDetailsFolder.find(await _db, finder: finder);
      if (recordSnapshot.isNotEmpty) {
        final capturedPokemons =
            recordSnapshot.map((map) => Pokemon.fromJson(map.value)).toList();

      // List all the types in all pokemons
        List<String> words = [];
        for (var pokemon in capturedPokemons) {
          var types = pokemon.types;
          if (types != null) {
            for (var type in types) {
              words.add(type.type.name);
            }
          }
        }

        if (words.isEmpty) return '';

      // Create a map to count occurrences
        final wordCount = <String, int>{};
        for (var word in words) {
          wordCount[word] = (wordCount[word] ?? 0) + 1;
        }

      // Find the most repeated word
        String mostRepeated = '';
        int maxCount = 0;
        bool isTie = false;
        wordCount.forEach((word, count) {
          if (count > maxCount) {
            mostRepeated = word;
            maxCount = count;
            isTie = false;
          } else if (count == maxCount) {
            isTie = true;
          }
        });

        return isTie ? '' : mostRepeated;
      }
      return '';
    } catch (e) {
      throw DatabaseError('Failed to calculate captured Pokemons: ${e.toString()}');
    }
  }

  /// Checks in the list of pokemon details if there are
  /// ocurrences in the pokemonEntries list, to know which
  /// pokemonEntries in the home_view are captured and mark like so
  Future<List<PokemonEntry>> checkCapturedPokemons(
      List<PokemonEntry> pokemonEntries) async {
    try {
      List<PokemonEntry> updatedList = [];
      for (var pokemonEntry in pokemonEntries) {
        final filter = Filter.and([
          Filter.equals('name', pokemonEntry.name),
          Filter.equals('isCaptured', true)
        ]);
        final finder = Finder(filter: filter);
        final recordSnapshot =
            await _pokemonDetailsFolder.findFirst(await _db, finder: finder);
        PokemonEntry updatedEntry = pokemonEntry;
        if (recordSnapshot != null) {
          updatedEntry = pokemonEntry.copyWith(isCaptured: true);
        }
        updatedList.add(updatedEntry);
      }
      return updatedList;
    } catch (e) {
      throw DatabaseError('Failed to check captured Pokemons: ${e.toString()}');
    }
  }
}