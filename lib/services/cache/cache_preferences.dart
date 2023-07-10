import 'package:u_todo/services/cache/cache.dart';
import 'package:npreferences/npreferences.dart';

/// Implement Storage by SharedPreferences
class CachePreferences extends Cache with NPreferences {}
