import 'package:flutter/material.dart';
import 'package:pokedex/core/helpers/string_helpers.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex/presentation/providers/captured_pokemon_list_provider.dart';
import 'package:pokedex/presentation/widgets/avatar.dart';
import 'package:pokedex/presentation/widgets/error_display_widget.dart';

class PokemonCapturedView extends ConsumerWidget {
  const PokemonCapturedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = AppTheme.of(context);
    final capturedPokemon = ref.watch(capturedPokemonListProvider);

    return capturedPokemon.when(
      data: (pokemons) => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(l10n.pokemonCaptured, style: theme.titleMedium),
            ),
            const Divider(),
            if (pokemons.isEmpty) Expanded(child: Center(child: Text(l10n.noCapturedPokemon))),
            Expanded(
              child: ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Avatar(pokemon: pokemon, size: 25),
                        title: Text(
                            StringHelpers.capitalizeFirstLetter(pokemon.name)),
                        onTap: () => context.pushNamed(
                          PokemonDetailPage.routeName,
                          queryParameters: {
                            'name': pokemon.name,
                            'url': pokemon.url
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator(color: theme.primary)),
      error: (error, stack) => ErrorDisplayWidget(
        error: error,
        onRetry: () {
          ref.invalidate(capturedPokemonListProvider);
        },
      ),
    );
  }
}