class PokemonTypeInfo {
  final String name;
  final String url;

  PokemonTypeInfo({
    required this.name,
    required this.url,
  });

  // fromJson
  factory PokemonTypeInfo.fromJson(Map<String, dynamic> json) {
    return PokemonTypeInfo(
      name: json['name'],
      url: json['url'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}