import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/constants.dart';
import 'package:pokedex/data/services/preferences/key_value_storage_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_language_provider.g.dart';

@riverpod
class AppLanguage extends _$AppLanguage {
  final keyValueStorageService = KeyValueStorageServiceImpl();

  @override
  Future<Locale> build() async {
    final locale =
        await keyValueStorageService.getValue<String>(Constants.language) ??
            'es';
    return Locale(locale);
  }

  Future<void> changeLanguage(String languageCode) async {
    late Locale locale;
    final code =
        await keyValueStorageService.getValue<String>(Constants.language);
    if (code != null && code == languageCode) {
      return;
    }
    if (languageCode == "en") {
      await keyValueStorageService.setKeyValue(Constants.language, 'en');
      locale = const Locale('en', '');
    } else {
      await keyValueStorageService.setKeyValue(Constants.language, 'es');
      locale = const Locale('es', 'ES');
    }
    state = await AsyncValue.guard(() async {
      return locale;
    });
  }

  Future<Locale> getLocale() async {
    return Locale(
        await keyValueStorageService.getValue<String>(Constants.language) ??
            'es');
  }
}