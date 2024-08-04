import 'package:personal_home/core/adapter/database/sqlite.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/port/repository/device.dart';
import 'package:personal_home/core/repository/model/device.dart';

class DeviceRepository implements DevicePortRepository {
  final SqliteAdapter _sqlite;

  DeviceRepository(this._sqlite);

  @override
  Future<List<DeviceEntity>> getList() async {
    // final db = await _sqlite.database;
    // List<Map<String, Object?>> res = await db.rawQuery('SELECT * FROM device');
    // return res.map((val) => DeviceEntity.fromJson(val)).toList();

    final List<DeviceModel> res = [
      const DeviceModel(
          id: 1,
          ipv4: '192.168.1.1',
          ipv6: '',
          macAddress: '00-B0-D0-63-C2-26'),
      const DeviceModel(
          id: 2,
          ipv4: '192.168.1.2',
          ipv6: '',
          macAddress: '00-B0-D0-63-C2-27'),
      const DeviceModel(
          id: 3,
          ipv4: '192.168.1.3',
          ipv6: '',
          macAddress: '00-B0-D0-63-C2-28'),
      const DeviceModel(
          id: 4,
          ipv4: '192.168.1.4',
          ipv6: '',
          macAddress: '00-B0-D0-63-C2-29'),
      const DeviceModel(
          id: 5,
          ipv4: '192.168.1.5',
          ipv6: '',
          macAddress: '00-B0-D0-63-C2-30'),
    ];
    return res.map((val) => val.toEntity()).toList();
  }

  @override
  Future<void> create(DeviceEntity device) async {
    // final db = await _sqlite.database;
    // await db.transaction((txn) async {
    //   int id1 = await txn.rawInsert(
    //       'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    //   print('inserted1: $id1');
    // });
  }
}
