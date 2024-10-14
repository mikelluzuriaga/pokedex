import 'pokemon_type.dart';

class Pokemon {
  final int? id;
  final String name;
  final String? photo;
  final int? height;
  final int? weight;
  final List<PokemonType>? types;
  final bool isCaptured;
  final String url;

  Pokemon({
    required this.id,
    required this.name,
    required this.photo,
    required this.height,
    required this.weight,
    required this.types,
    this.isCaptured = false,
    this.url = '',
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'] ?? '',
      photo: json['photo'],
      height: json['height'],
      weight: json['weight'],
      types: json['types'] != null
          ? (json['types'] as List)
              .map((type) => PokemonType.fromJson(type))
              .toList()
          : null,
      isCaptured: json['isCaptured'] ?? false,
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'types': types
          ?.map((type) => {
                'slot': type.slot,
                'type': {
                  'name': type.type.name,
                  'url': type.type.url,
                },
              })
          .toList(),
      'height': height,
      'weight': weight,
      'isCaptured': isCaptured,
      'url': url,
    };
  }

  Pokemon copyWith({
    int? id,
    String? name,
    String? photo,
    int? height,
    int? weight,
    List<PokemonType>? types,
    bool? isCaptured,
    String? url,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
      isCaptured: isCaptured ?? this.isCaptured,
      url: url ?? this.url,
    );
  }
}
