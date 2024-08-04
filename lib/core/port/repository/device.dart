import 'package:personal_home/core/entity/device.dart';

abstract class DevicePortRepository {
  Future<List<DeviceEntity>> getList();
  Future<void> create(DeviceEntity device);
}
