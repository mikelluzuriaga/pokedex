import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_provider.g.dart';

@riverpod
class SettingsViewPr extends _$SettingsViewPr {
  @override
  SettingsState build() {
    return SettingsState();
  }
}

class SettingsState {
  ThemeMode themeMode;
  String language;

  SettingsState({
    this.themeMode = ThemeMode.system,
    this.language = 'en',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? language,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}