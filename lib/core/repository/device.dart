import 'package:personal_home/core/adapter/database/sqlite.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/port/repository/device.dart';

class DeviceRepository implements DevicePortRepository {
  final SqliteAdapter _sqlite;

  DeviceRepository(this._sqlite);

  @override
  Future<List<DeviceEntity>> getList() async {
    final db = await _sqlite.database;
    List<Map<String, Object?>> res = await db.rawQuery('SELECT * FROM device');
    return res.map((val) => DeviceEntity.fromJson(val)).toList();
  }
}
