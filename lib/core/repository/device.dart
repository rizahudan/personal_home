import 'package:personal_home/core/adapter/database/sqlite.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/port/repository/device.dart';
import 'package:personal_home/core/repository/model/device.dart';
import 'package:sqflite/sqflite.dart';

class DeviceRepository implements DevicePortRepository {
  final SqliteAdapter _sqlite;

  DeviceRepository(this._sqlite);

  @override
  Future<List<DeviceEntity>> getList() async {
    final db = await _sqlite.database;
    List<Map<String, Object?>> res = await db.rawQuery('SELECT * FROM device');
    return res.map((val) => DeviceEntity.fromJson(val)).toList();
  }

  @override
  Future<void> insert(DeviceEntity device) async {
    final deviceModel = DeviceModel(
      id: device.id,
      macAddress: device.macAddress,
      label: device.label,
      ipv4Cidr: device.ipv4Cidr,
    );
    final db = await _sqlite.database;
    await db.transaction((txn) async {
      await txn.insert(
        'device',
        deviceModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  @override
  Future<void> delete(int id) async {
    final db = await _sqlite.database;
    await db.transaction((txn) async {
      await txn.delete(
        'device',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  @override
  Future<void> update(DeviceEntity device) async {
    final deviceModel = DeviceModel(
      id: device.id,
      macAddress: device.macAddress,
      label: device.label,
      ipv4Cidr: device.ipv4Cidr,
    );

    final db = await _sqlite.database;
    await db.transaction((txn) async {
      await txn.update(
        'device',
        deviceModel.toJson(),
        where: 'id = ?',
        whereArgs: [deviceModel.id],
      );
    });
  }
}
