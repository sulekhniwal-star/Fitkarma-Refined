import 'dart:convert';
import 'package:drift/drift.dart';

/// Converter for storing dynamic Maps as JSON strings in the database.
class JsonMapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonMapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    return json.decode(fromDb) as Map<String, dynamic>;
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}

/// Converter for storing List<String> as JSON strings in the database.
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List).map((e) => e as String).toList();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

/// Converter for storing List of Maps as JSON strings.
class MapListConverter extends TypeConverter<List<Map<String, dynamic>>, String> {
  const MapListConverter();

  @override
  List<Map<String, dynamic>> fromSql(String fromDb) {
    return (json.decode(fromDb) as List).map((e) => e as Map<String, dynamic>).toList();
  }

  @override
  String toSql(List<Map<String, dynamic>> value) {
    return json.encode(value);
  }
}
