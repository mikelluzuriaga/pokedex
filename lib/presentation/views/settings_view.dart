import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/app_theme.dart';
import 'package:pokedex/presentation/providers/commons/commons_provider.dart';
import 'package:pokedex/presentation/providers/locale/app_language_provider.dart';
import 'package:pokedex/presentation/providers/settings_view/theme_mode_select_provider.dart';
import 'package:pokedex/presentation/widgets/custom_sliding_segment.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = AppTheme.of(context);
    final appLanguage = ref.watch(appLanguageProvider);
    final themeModes = ref.watch(themeModesProvider);
    final themeModeSelect = ref.watch(themeModeSelectProvider);
    ThemeModeState themeModeState = ThemeModeState(
      isDarkMode: false,
      selectedMode: ThemeMode.light,
    );
    themeModeSelect.whenData((data) {
      themeModeState = data;
    });

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                l10n.menuSettings,
                style: theme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Text(l10n.settingsLanguage, style: theme.titleSmall),
          const SizedBox(height: 10),

          // Locale
          DropdownButtonFormField(
            value: appLanguage.value?.languageCode,
            isExpanded: false,
            items: [
              DropdownMenuItem(
                alignment: Alignment.center,
                value: 'es',
                child: CountryFlag.fromLanguageCode(
                  'es',
                  height: 20,
                  width: 40,
                ),
              ),
              DropdownMenuItem(
                alignment: Alignment.center,
                value: 'en',
                child: CountryFlag.fromLanguageCode(
                  'en',
                  height: 20,
                  width: 40,
                ),
              )
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            ),
            onChanged: (value) {
              ref
                  .read(appLanguageProvider.notifier)
                  .changeLanguage(value as String);
            },
          ),

          // Theme mode
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(l10n.settingsTheme, style: theme.titleSmall),
          ),
          CustomSlidingSegment(
            items: themeModes,
            groupValue: themeModeState.selectedMode,
            onValueChanged: (newSelection) {
              ref
                  .read(themeModeSelectProvider.notifier)
                  .changeMode(newSelection);
            },
          ),
        ],
      ),
    );
  }
}