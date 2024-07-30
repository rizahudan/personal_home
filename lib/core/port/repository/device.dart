import 'package:personal_home/core/entity/device.dart';

abstract class DevicePortRepository {
  Future<List<DeviceEntity>> getList();
}
