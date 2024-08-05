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

    // final List<DeviceModel> res = [
    //   const DeviceModel(
    //     id: 1,
    //     ipv4: '192.168.1.1',
    //     ipv6: '',
    //     macAddress: '00-B0-D0-63-C2-26',
    //     label: "label 1",
    //   ),
    //   const DeviceModel(
    //     id: 2,
    //     ipv4: '192.168.1.2',
    //     ipv6: '',
    //     macAddress: '00-B0-D0-63-C2-27',
    //     label: "label 2",
    //   ),
    //   const DeviceModel(
    //     id: 3,
    //     ipv4: '192.168.1.3',
    //     ipv6: '',
    //     macAddress: '00-B0-D0-63-C2-28',
    //     label: "label 3",
    //   ),
    //   const DeviceModel(
    //     id: 4,
    //     ipv4: '192.168.1.4',
    //     ipv6: '',
    //     macAddress: '00-B0-D0-63-C2-29',
    //     label: "label 4",
    //   ),
    //   const DeviceModel(
    //     id: 5,
    //     ipv4: '192.168.1.5',
    //     ipv6: '',
    //     macAddress: '00-B0-D0-63-C2-30',
    //     label: "label 5",
    //   ),
    // ];
    // return res.map((val) => val.toEntity()).toList();
  }

  @override
  Future<void> insert(DeviceEntity device) async {
    final deviceModel = DeviceModel(
      id: device.id,
      macAddress: device.macAddress,
      label: device.label,
      ipv4: device.ipv4,
      ipv6: device.ipv6,
    );
    final db = await _sqlite.database;
    await db.transaction((txn) async {
      int id = await txn.insert(
        'device',
        deviceModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('inserted1: $id');
    });
  }
}
