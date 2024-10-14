import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/themes.dart';
import 'package:pokedex/presentation/providers/home/home_page_provider.dart';
import 'package:pokedex/presentation/views/views.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = 'home-page';
  final int currentIndex;
  HomePage({
    super.key,
    required this.currentIndex,
  });

  final viewRoutes = [
    const HomeView(),
    const PokemonCapturedView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = AppTheme.of(context);
    final homeIndex = ref.watch(homePageIndexProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        leadingWidth: 55,
        leading: Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: Image.asset(('assets/images/pokeball.png')),
        ),
        title: Text('PKDX', style: theme.appBarTitle,),
      ),
      body: IndexedStack(
        index: homeIndex ?? currentIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.primary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.menuHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.catching_pokemon),
            label: l10n.menuCaptured,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.menuSettings,
          ),
        ],
        currentIndex: homeIndex ?? currentIndex,
        onTap: (index) {
          ref.read(homePageIndexProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}