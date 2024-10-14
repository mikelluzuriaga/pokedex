import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pokedex/core/constants/colors.dart';
import 'package:pokedex/core/constants/constants.dart';
import 'package:pokedex/data/services/preferences/key_value_storage_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_select_provider.g.dart';

@riverpod
class ThemeModeSelect extends _$ThemeModeSelect {
  @override
  Future<ThemeModeState> build() async {
    final themeMode = await getMode();
    bool isDarkMode = false;
    if (themeMode == ThemeMode.system) {
      isDarkMode = isSystemDark();
    } else {
      isDarkMode = themeMode == ThemeMode.dark ? true : false;
    }
    final repeatedType = await getMostRepeatedType();
    Color initialColor = PokemonColors.getPokemonColor(repeatedType);

    return ThemeModeState(
      selectedMode: themeMode,
      isDarkMode: isDarkMode,
      primary: initialColor,
      primaryDark: initialColor,
      mostRepeatedType: repeatedType,
    );
  }

  Future<ThemeMode> getMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeModeString = sharedPreferences.getString('themeMode');
    return switchMode(themeModeString);
  }

  Future<String> getMostRepeatedType() async {
    final keyValueStorageService = KeyValueStorageServiceImpl();
    final type = await keyValueStorageService
        .getValue<String>(Constants.mostRepeatedType);
    return type ?? '';
  }

  Future<void> checkUiColorShouldChange(String type) async {
    final actualState = state.valueOrNull;
    if (actualState?.mostRepeatedType != type) {
      Color newColor = PokemonColors.getPokemonColor(type);
      changePrimaryColor(newColor, repeatedType: type);
    }
  }

  void changeMode(ThemeMode themeMode) async {
    final actualState = state.valueOrNull;
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('themeMode', themeMode.toString());
    bool isDarkMode = false;
    if (themeMode == ThemeMode.system) {
      isDarkMode = isSystemDark();
    } else {
      isDarkMode = themeMode == ThemeMode.dark ? true : false;
    }
    final updatedState = actualState!.copyWith(
      selectedMode: themeMode,
      isDarkMode: isDarkMode,
    );
    state = AsyncValue.data(updatedState);
  }

  ThemeMode switchMode(String? themeModeString) {
    if (themeModeString != null) {
      switch (themeModeString) {
        case 'ThemeMode.light':
          return ThemeMode.light;
        case 'ThemeMode.dark':
          return ThemeMode.dark;
      }
    }
    return ThemeMode.system;
  }

  bool isSystemDark() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  void changePrimaryColor(Color color,{String? repeatedType}) {
    state = const AsyncValue.loading();
    final actualState = state.valueOrNull;
    final updatedState = actualState!.copyWith(
      primary: color,
      primaryDark: color,
      mostRepeatedType: repeatedType ?? actualState.mostRepeatedType,
    );
    state = AsyncValue.data(updatedState);
  }
}

class ThemeModeState {
  ThemeModeState({
    required this.selectedMode,
    required this.isDarkMode,
    this.mostRepeatedType = '',
    Color? primary,
    this.primaryDark = const Color.fromARGB(255, 240, 0, 0),
  }) : primary = primary ?? AppColors.primary;

  final ThemeMode selectedMode;
  final bool isDarkMode;
  final Color primary;
  final Color primaryDark;
  final String mostRepeatedType;

  ThemeModeState copyWith({
    ThemeMode? selectedMode,
    bool? isDarkMode,
    Color? primary,
    Color? primaryDark,
    String? mostRepeatedType,
  }) {
    return ThemeModeState(
      selectedMode: selectedMode ?? this.selectedMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      mostRepeatedType: mostRepeatedType ?? this.mostRepeatedType,
    );
  }
}