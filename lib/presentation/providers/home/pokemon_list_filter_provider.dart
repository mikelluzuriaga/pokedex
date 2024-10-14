

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_list_filter_provider.g.dart';

@riverpod
class PokemonListFilter extends _$PokemonListFilter {
  @override
  String build() {
    return '';
  }

  void setFilter(String filter) {
    state = filter.toLowerCase();
  }
}