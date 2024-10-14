import 'package:pokedex/data/models/pokemon_list_item_response.dart';

class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItemResponse> results;

  PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List?)
              ?.map((i) => PokemonListItemResponse.fromJson(i))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((i) => i.toJson()).toList(),
    };
  }
}