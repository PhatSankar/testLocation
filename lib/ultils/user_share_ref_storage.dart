
import 'package:shared_preferences/shared_preferences.dart';

class UserShareRefStorage {

  static const String _keyName = 'nameShareRefStorage';

  static Future setName(String value) async {
    final prefStorage = await SharedPreferences.getInstance();
    await prefStorage.setString(_keyName, value);
  }

  static Future<String?> getName() async {
    final prefStorage = await SharedPreferences.getInstance();
    return prefStorage.getString(_keyName);
  }

  static Future deleteByKey() async {
    final prefStorage = await SharedPreferences.getInstance();
    prefStorage.remove(_keyName);
  }

}