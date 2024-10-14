import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/select_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final themeModesProvider = Provider<List<SelectItem>>((ref) {
  return [
    const SelectItem(code: ThemeMode.light, value: 'Light'),
    const SelectItem(code: ThemeMode.dark, value: 'Dark'),
    const SelectItem(code: ThemeMode.system, value: 'System'),
  ];
});
