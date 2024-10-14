import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/router/app_router.dart';
import 'package:pokedex/core/theme/themes.dart';
import 'presentation/providers/settings_view/app_language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/presentation/providers/settings_view/theme_mode_select_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final themeModeSelect = ref.watch(themeModeSelectProvider);
    ThemeModeState themeModeState = ThemeModeState(
      isDarkMode: false,
      selectedMode: ThemeMode.light,
    );
    themeModeSelect.whenData((data) {
      themeModeState = data;
    });

    return AppTheme(
      lightTheme: AppLightThemeData(primary: themeModeState.primary),
      darkTheme: AppDarkThemeData(primary: themeModeState.primaryDark),
      child: MaterialApp.router(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', ''),
        ],
        locale: ref.watch(appLanguageProvider).value,
        theme: AppLightThemeData(primary: themeModeState.primary)
            .materialThemeData,
        darkTheme: AppDarkThemeData(primary: themeModeState.primaryDark).materialThemeData,
        themeMode: themeModeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        routerConfig: appRouter,
      ),
    );
  }
}