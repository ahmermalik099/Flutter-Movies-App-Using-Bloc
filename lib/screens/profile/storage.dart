
import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';

class Storage {
  final FlutterSecureStorageWeb storage =  FlutterSecureStorageWeb();

  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value, options: {});
  }

}