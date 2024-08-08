import 'package:personal_home/core/entity/device.dart';

abstract class DevicePortRepository {
  Future<List<DeviceEntity>> getList();
  Future<void> insert(DeviceEntity device);
  Future<void> delete(int id);
  Future<void> update(DeviceEntity device);
}
