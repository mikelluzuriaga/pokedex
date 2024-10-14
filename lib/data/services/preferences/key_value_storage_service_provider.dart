import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/services/preferences/key_value_storage_service_impl.dart';

final sharedPreferencesProvider = Provider<KeyValueStorageServiceImpl>((ref) {
  return KeyValueStorageServiceImpl();
});