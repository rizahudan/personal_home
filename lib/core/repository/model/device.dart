import 'package:equatable/equatable.dart';
import 'package:personal_home/core/entity/device.dart';

class DeviceModel extends Equatable {
  final int id;
  final String ipv4;
  final String ipv6;
  final String macAddress;

  const DeviceModel({
    required this.id,
    required this.ipv4,
    required this.ipv6,
    required this.macAddress,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json["id"] ?? 0,
      ipv4: json["ipv4"] ?? "",
      ipv6: json["ipv6"] ?? "",
      macAddress: json["mac_address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ipv4": ipv4,
        "ipv6": ipv6,
        "mac_address": macAddress,
      };

  @override
  List<Object?> get props => [
        id,
        ipv4,
        ipv6,
        macAddress,
      ];

  DeviceEntity toEntity() {
    return DeviceEntity(
        id: id, ipv4: ipv4, ipv6: ipv6, macAddress: macAddress, status: false);
  }
}
