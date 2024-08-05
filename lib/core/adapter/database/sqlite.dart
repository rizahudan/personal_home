import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteConfig extends Equatable {
  const SqliteConfig({
    required this.dbName,
  });

  final String dbName;

  factory SqliteConfig.fromJson(Map<String, dynamic> json) {
    return SqliteConfig(
      dbName: json["db_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "db_name": dbName,
      };

  @override
  List<Object?> get props => [
        dbName,
      ];
}

class SqliteAdapter {
  late SqliteConfig _config;
  static final SqliteAdapter _instance = SqliteAdapter._internal();
  static Database? _database;

  factory SqliteAdapter(SqliteConfig config) {
    _instance._config = config;
    return _instance;
  }

  SqliteAdapter._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _config.dbName);

    // TODO: disable delete db
    // Delete the database
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            create table device ( 
              id integer primary key autoincrement, 
              mac_address text not null,
              label text not null,
              ipv4 text not null,
              ipv6 text not null
            )
          ''');
      },
    );
  }
}
