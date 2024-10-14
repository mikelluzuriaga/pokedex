class PokemonEntry {
  final String name;
  final String url;
  final bool isCaptured;

  PokemonEntry({
    required this.name,
    required this.url,
    this.isCaptured = false,
  });

  factory PokemonEntry.fromJson(Map<String, dynamic> json) {
    return PokemonEntry(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      isCaptured: json['isCaptured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
      "isCaptured": isCaptured,
    };
  }

  PokemonEntry copyWith({
    String? name,
    String? url,
    bool? isCaptured,
  }) {
    return PokemonEntry(
      name: name ?? this.name,
      url: url ?? this.url,
      isCaptured: isCaptured ?? this.isCaptured,
    );
  }
}
