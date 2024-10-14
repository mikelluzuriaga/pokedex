class PokemonListItemResponse {
  final String name;
  final String url;

  PokemonListItemResponse({
    required this.name,
    required this.url,
  });

  factory PokemonListItemResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListItemResponse(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}