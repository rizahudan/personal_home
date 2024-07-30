import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Config extends Equatable {
  const Config({
    required this.database,
  });

  final Database? database;

  factory Config.fromJson(Map<String, dynamic> json){
    return Config(
      database: json["database"] == null ? null : Database.fromJson(json["database"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "database": database?.toJson(),
  };

  @override
  List<Object?> get props => [
    database, ];
}

class Database extends Equatable {
  const Database({
    required this.sqlite,
  });

  final Sqlite? sqlite;

  factory Database.fromJson(Map<String, dynamic> json){
    return Database(
      sqlite: json["sqlite"] == null ? null : Sqlite.fromJson(json["sqlite"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "sqlite": sqlite?.toJson(),
  };

  @override
  List<Object?> get props => [
    sqlite, ];
}

class Sqlite extends Equatable {
  const Sqlite({
    required this.dbName,
  });

  final String dbName;

  factory Sqlite.fromJson(Map<String, dynamic> json){
    return Sqlite(
      dbName: json["db_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "db_name": dbName,
  };

  @override
  List<Object?> get props => [
    dbName, ];
}

Future<Config> newConfig() async {
  final yamlString = await rootBundle.loadString('cfg/config.yaml');
  final parsedYaml = loadYaml(yamlString);
  final Config cfg = Config.fromJson(_convertYamlToMap(parsedYaml));
  return cfg;
}

Map<String, dynamic> _convertYamlToMap(YamlMap yamlMap) {
  final map = <String, dynamic>{};
  yamlMap.forEach((key, value) {
    if (value is YamlMap) {
      map[key] = _convertYamlToMap(value);
    } else if (value is YamlList) {
      map[key] = value.toList();
    } else {
      map[key] = value;
    }
  });
  return map;
}