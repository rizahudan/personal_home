import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/port/repository/device.dart';
import 'package:personal_home/core/port/service/device.dart';

class DeviceService implements DevicePortService {
  final DevicePortRepository _repo;

  DeviceService(this._repo);

  @override
  Future<List<DeviceEntity>> getList() async {
    return await _repo.getList();
  }

  @override
  Future<void> insert(DeviceEntity device) async {
    return await _repo.insert(device);
  }

  @override
  Future<void> delete(int id) async {
    return await _repo.delete(id);
  }

  @override
  Future<void> update(DeviceEntity device) async {
    return await _repo.update(device);
  }
}
