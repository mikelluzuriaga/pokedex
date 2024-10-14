import 'package:go_router/go_router.dart';
import 'package:pokedex/presentation/pages/home_page.dart';
import 'package:pokedex/presentation/pages/pokemon_detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      name: HomePage.routeName,
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomePage(currentIndex: pageIndex);
      },
    ),
    GoRoute(
      name: PokemonDetailPage.routeName,
      path: '/${PokemonDetailPage.routeName}',
      builder: (context, state) {
        return PokemonDetailPage(
          pokemonName: state.uri.queryParameters['name'] ?? '',
          pokemonUrl: state.uri.queryParameters['url'] ?? '',
        );
      },
    ),
  ],
);