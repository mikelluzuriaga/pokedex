
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final screenWidthProvider = Provider<double>((ref) {
  return kIsWeb ? 600 : double.infinity;
});