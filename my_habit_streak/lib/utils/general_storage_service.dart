import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GeneralStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _generalKeyPrefix = 'general_';

  Future<void> saveData(String key, dynamic value) async {
    final dataObject = {
      'value': value,
      'type': value.runtimeType.toString(),
    };
    await _storage.write(
      key: _generalKeyPrefix + key,
      value: dataObject.toString(),
    );
  }

  Future<dynamic> getData(String key) async {
    // Read the stored string using the key
    final storedValue = await _storage.read(key: _generalKeyPrefix + key);
    if (storedValue == null) return null;

    try {
      // Parse the string representation into a Map
      final parsedData = _parseStoredValue(storedValue);
      final value = parsedData['value'];
      final type = parsedData['type'];

      // Convert value to the original type
      switch (type) {
        case 'String':
          return value;
        case 'int':
          return int.tryParse(value!) ?? value;
        case 'double':
          return double.tryParse(value!) ?? value;
        case 'bool':
          return value!.toLowerCase() == 'true';
        case 'Null':
          return null;
        default:
          return value!; // Fallback for unsupported types
      }
    } catch (e) {
      return null; // Return null on parsing errors
    }
  }

  Map<String, String> _parseStoredValue(String storedValue) {
    // Remove curly braces and split into key-value pairs
    final cleanString = storedValue.replaceAll(RegExp(r'[{}]'), '');
    final parts = cleanString.split(', ');

    final result = <String, String>{};
    for (final part in parts) {
      final keyValue = part.split(': ');
      if (keyValue.length == 2) {
        // Add key-value pair after trimming spaces
        result[keyValue[0].trim()] = keyValue[1].trim();
      }
    }
    return result;
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: _generalKeyPrefix + key);
  }
}
