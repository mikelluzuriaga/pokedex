import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/theme/themes.dart';
import 'package:pokedex/domain/entities/entities.dart';

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.pokemon,
    this.size = 100,
  });

  final Pokemon pokemon;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);

    return CircleAvatar(
      backgroundColor: theme.grey,
      radius: size,
      child: Image.network(
        pokemon.photo ?? '',
        height: size * 2,
        width: size * 2,
        fit: BoxFit.contain,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: theme.primary,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: 200,
            color: Colors.grey[300],
            child: Image.asset('assets/images/placeholder.webp'),
          );
        },
      ),
    );
  }
}