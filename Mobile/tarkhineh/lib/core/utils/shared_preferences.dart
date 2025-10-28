import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static const String _keySelectedBranchId = 'selectedBranchId';
  static const String _keySelectedBranchName = 'selectedBranchName';

  static Future<void> saveBranch({
    required String id,
    required String name,
  }) async {
    await _prefs?.setString(_keySelectedBranchId, id);
    await _prefs?.setString(_keySelectedBranchName, name);
  }

  static String? getBranchId() => _prefs?.getString(_keySelectedBranchId);
  static String? getBranchName() => _prefs?.getString(_keySelectedBranchName);

  static Future<void> clearBranch() async {
    await _prefs?.remove(_keySelectedBranchId);
    await _prefs?.remove(_keySelectedBranchName);
  }

  static Future<void> clearAll() async => _prefs?.clear() ?? Future.value();
}
