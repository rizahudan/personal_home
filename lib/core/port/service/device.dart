import 'package:personal_home/core/entity/device.dart';

abstract class DevicePortService {
  Future<List<DeviceEntity>> getList();
  Future<void> insert(DeviceEntity device);
}
