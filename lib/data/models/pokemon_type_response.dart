class PokemonTypeResponse {
  final int slot;
  final PokemonTypeInfoResponse type;

  PokemonTypeResponse({
    required this.slot,
    required this.type,
  });

  factory PokemonTypeResponse.fromJson(Map<String, dynamic> json) {
    return PokemonTypeResponse(
      slot: json['slot'] ?? 0,
      type: PokemonTypeInfoResponse.fromJson(json['type'] ?? {}),
    );
  }
}

class PokemonTypeInfoResponse {
  final String name;
  final String url;

  PokemonTypeInfoResponse({
    required this.name,
    required this.url,
  });

  factory PokemonTypeInfoResponse.fromJson(Map<String, dynamic> json) {
    return PokemonTypeInfoResponse(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}