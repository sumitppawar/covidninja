import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyValueStore {
  FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    storage.delete(key: key);
  }

  Future<String> get(String key) async {
    return storage.read(key: key);
  }
}
