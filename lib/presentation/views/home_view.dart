import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/themes.dart';
import 'package:pokedex/domain/entities/entities.dart';
import 'package:pokedex/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex/presentation/providers/home/pokemon_list_filter_provider.dart';
import 'package:pokedex/presentation/providers/pokemon_list_filtered_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/presentation/providers/ui/screen_constraints.dart';
import 'package:pokedex/presentation/widgets/error_display_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = AppLocalizations.of(context);
    final filteredPokemonListAsync = ref.watch(pokemonListFilteredProvider);
    final screenConstraints = ref.watch(screenWidthProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(l10n.pokemonList, style: theme.titleMedium),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenConstraints),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextFormField(
                  decoration: theme.roundedBorderContainer.copyWith(
                    hintText: 'Search Pokemon',
                  ),
                  onChanged: (value) {
                    ref.read(pokemonListFilterProvider.notifier).setFilter(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: filteredPokemonListAsync.when(
                data: (pokemonList) => RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(pokemonListFilteredProvider);
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenConstraints),
                    child: ListView.builder(
                      itemCount: pokemonList.length,
                      itemBuilder: (context, index) {
                        return _PokemonCard(pokemon: pokemonList[index]);
                      },
                    ),
                  ),
                ),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: theme.primary,
                  ),
                ),
                error: (error, stack) => ErrorDisplayWidget(
                  error: error,
                  onRetry: () {
                    ref.invalidate(pokemonListFilteredProvider);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PokemonCard extends ConsumerWidget {
  const _PokemonCard({
    required this.pokemon,
  });

  final PokemonEntry pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          onTap: () => context.pushNamed(
            PokemonDetailPage.routeName,
            queryParameters: {'name': pokemon.name, 'url': pokemon.url},
          ),
          leading: const Icon(Icons.catching_pokemon),
          title: Text(
            pokemon.name.toUpperCase(),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.catching_pokemon,
            color: pokemon.isCaptured ? Colors.red : Colors.green,
          ),
        ),
        const Divider(),
      ],
    );
  }
}