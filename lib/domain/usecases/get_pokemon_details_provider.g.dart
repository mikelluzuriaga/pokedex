// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pokemon_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPokemonDetailsHash() => r'6248b547034b87b6066159916b81afcc70e122ee';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getPokemonDetails].
@ProviderFor(getPokemonDetails)
const getPokemonDetailsProvider = GetPokemonDetailsFamily();

/// See also [getPokemonDetails].
class GetPokemonDetailsFamily extends Family<AsyncValue<Pokemon>> {
  /// See also [getPokemonDetails].
  const GetPokemonDetailsFamily();

  /// See also [getPokemonDetails].
  GetPokemonDetailsProvider call({
    required String pokemonName,
    required String pokemonUrl,
  }) {
    return GetPokemonDetailsProvider(
      pokemonName: pokemonName,
      pokemonUrl: pokemonUrl,
    );
  }

  @override
  GetPokemonDetailsProvider getProviderOverride(
    covariant GetPokemonDetailsProvider provider,
  ) {
    return call(
      pokemonName: provider.pokemonName,
      pokemonUrl: provider.pokemonUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPokemonDetailsProvider';
}

/// See also [getPokemonDetails].
class GetPokemonDetailsProvider extends AutoDisposeFutureProvider<Pokemon> {
  /// See also [getPokemonDetails].
  GetPokemonDetailsProvider({
    required String pokemonName,
    required String pokemonUrl,
  }) : this._internal(
          (ref) => getPokemonDetails(
            ref as GetPokemonDetailsRef,
            pokemonName: pokemonName,
            pokemonUrl: pokemonUrl,
          ),
          from: getPokemonDetailsProvider,
          name: r'getPokemonDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPokemonDetailsHash,
          dependencies: GetPokemonDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetPokemonDetailsFamily._allTransitiveDependencies,
          pokemonName: pokemonName,
          pokemonUrl: pokemonUrl,
        );

  GetPokemonDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pokemonName,
    required this.pokemonUrl,
  }) : super.internal();

  final String pokemonName;
  final String pokemonUrl;

  @override
  Override overrideWith(
    FutureOr<Pokemon> Function(GetPokemonDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPokemonDetailsProvider._internal(
        (ref) => create(ref as GetPokemonDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pokemonName: pokemonName,
        pokemonUrl: pokemonUrl,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Pokemon> createElement() {
    return _GetPokemonDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPokemonDetailsProvider &&
        other.pokemonName == pokemonName &&
        other.pokemonUrl == pokemonUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pokemonName.hashCode);
    hash = _SystemHash.combine(hash, pokemonUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPokemonDetailsRef on AutoDisposeFutureProviderRef<Pokemon> {
  /// The parameter `pokemonName` of this provider.
  String get pokemonName;

  /// The parameter `pokemonUrl` of this provider.
  String get pokemonUrl;
}

class _GetPokemonDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Pokemon>
    with GetPokemonDetailsRef {
  _GetPokemonDetailsProviderElement(super.provider);

  @override
  String get pokemonName => (origin as GetPokemonDetailsProvider).pokemonName;
  @override
  String get pokemonUrl => (origin as GetPokemonDetailsProvider).pokemonUrl;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
