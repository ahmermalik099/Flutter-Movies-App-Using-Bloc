import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';

class Storage {
  final FlutterSecureStorageWeb storage = FlutterSecureStorageWeb();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value, options: {});
  }

  Future<String?> readSecureData(String key) async {
    return await storage.read(key: key, options: {});
  }

  Future<void> deleteAll() async {
    await storage.deleteAll(options: {});
  }

  Future<Map<String, String>> readAll() async {
    return await storage.readAll(options: {});
  }
}
