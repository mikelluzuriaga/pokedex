import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDbService {
  static final SembastDbService _singleton = SembastDbService._internal();
  Database? _db;

  SembastDbService._internal();

  factory SembastDbService() {
    return _singleton;
  }

  Future<Database> get database async {
    return _db ?? await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      return databaseFactoryWeb.openDatabase('pokemon.db');
    } else {
      final appDocDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocDir.path, 'pokemon.db');
      return databaseFactoryIo.openDatabase(dbPath);
    }
  }
}