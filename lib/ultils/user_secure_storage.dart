
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecuredStorage {
  static const _securedStorage = FlutterSecureStorage();
  static const String _keyName = 'nameSecureStorage';

  static Future setName(String value) async =>
      await _securedStorage.write(key: _keyName, value: value);

  static Future<String?> getName() async =>
      await _securedStorage.read(key: _keyName);

  static Future<Map<String, String>> getAll() async =>
      await _securedStorage.readAll();

  static Future deleteAll() async =>
      await _securedStorage.deleteAll();

  static Future deleteByKey() async =>
      await _securedStorage.delete(key: _keyName);

}