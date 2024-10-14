import 'package:flutter/material.dart';
import 'package:pokedex/core/helpers/helpers.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/app_theme.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/domain/usecases/get_pokemon_details_provider.dart';
import 'package:pokedex/domain/usecases/toggle_captured_pokemon_uc_provider.dart';
import 'package:pokedex/presentation/providers/captured_pokemon_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/presentation/providers/pokemon_list_provider.dart';
import 'package:pokedex/presentation/providers/settings_view/theme_mode_select_provider.dart';
import 'package:pokedex/presentation/providers/ui/screen_constraints.dart';
import 'package:pokedex/presentation/widgets/avatar.dart';
import 'package:pokedex/presentation/widgets/error_display_widget.dart';

class PokemonDetailPage extends ConsumerWidget {
  static const String routeName = 'pokemon-detail-page';
  final String pokemonName;
  final String pokemonUrl;

  const PokemonDetailPage({
    super.key,
    required this.pokemonName,
    required this.pokemonUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = AppLocalizations.of(context);
    final pokemonDetail = ref.watch(getPokemonDetailsProvider(
      pokemonName: pokemonName,
      pokemonUrl: pokemonUrl,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(l10n.pokemonDetails),
      ),
      body: SafeArea(
        child: pokemonDetail.when(
          data: (pokemon) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _Avatar(pokemon: pokemon),
                          _PokemonName(name: pokemon.name),
                          _PokemonInfo(pokemon: pokemon),
                        ],
                      ),
                    ),
                  ),
                  _CaptureButton(pokemon: pokemon),
                ],
              ),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(color: theme.primary),
          ),
          error: (error, stack) => ErrorDisplayWidget(
            error: error,
            onRetry: () {
              ref.invalidate(getPokemonDetailsProvider);
            },
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Pokemon pokemon;
  const _Avatar({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Avatar(pokemon: pokemon),
      ),
    );
  }
}

class _PokemonName extends StatelessWidget {
  final String name;
  const _PokemonName({required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Center(
        child: Text(
          StringHelpers.capitalizeFirstLetter(name),
          style: theme.titleBig,
        ),
      ),
    );
  }
}

class _PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonInfo({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: theme.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '${l10n.types}: ', style: theme.titleSmall),
                TextSpan(
                    text: pokemon.types != null
                        ? pokemon.types!
                            .map((type) => StringHelpers.capitalizeFirstLetter(
                                type.type.name))
                            .join(', ')
                        : ''),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '${l10n.height}: ', style: theme.titleSmall),
                TextSpan(text: '${pokemon.weight} hg'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '${l10n.weight}: ', style: theme.titleSmall),
                TextSpan(
                  text: '${pokemon.height} dm',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureButton extends ConsumerWidget {
  const _CaptureButton({required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final l10n = AppLocalizations.of(context);
    final toggleCapture = ref.watch(toggleCapturePokemonUcProvider);
    final screenConstraints = ref.watch(screenWidthProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenConstraints),
        child: ElevatedButton(
          onPressed: () async {
            final capturedType = await toggleCapture(pokemon);
            ref
                .read(themeModeSelectProvider.notifier)
                .checkUiColorShouldChange(capturedType);
            ref.invalidate(pokemonListProvider);
            ref.invalidate(getPokemonDetailsProvider);
            ref.invalidate(capturedPokemonListProvider);
          },
          style: const ButtonStyle().copyWith(
              backgroundColor: WidgetStatePropertyAll(
                  pokemon.isCaptured ? Colors.green : theme.primary)),
          child: Text(
              pokemon.isCaptured ? l10n.buttonRelease : l10n.buttonCapture),
        ),
      ),
    );
  }
}
