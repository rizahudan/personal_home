import 'package:equatable/equatable.dart';
import 'package:personal_home/core/entity/device.dart';

class DeviceModel extends Equatable {
  final int id;
  final String label;
  final String macAddress;
  final String ipv4;
  final String ipv6;

  const DeviceModel({
    required this.id,
    required this.macAddress,
    required this.label,
    required this.ipv4,
    required this.ipv6,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json["id"] ?? 0,
      macAddress: json["mac_address"] ?? "",
      label: json["label"] ?? "",
      ipv4: json["ipv4"] ?? "",
      ipv6: json["ipv6"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac_address": macAddress,
        "label": label,
        "ipv4": ipv4,
        "ipv6": ipv6,
      };

  @override
  List<Object?> get props => [
        id,
        macAddress,
        label,
        ipv4,
        ipv6,
      ];

  DeviceEntity toEntity() {
    return DeviceEntity(
      id: id,
      macAddress: macAddress,
      label: label,
      ipv4: ipv4,
      ipv6: ipv6,
      status: false,
    );
  }
}
