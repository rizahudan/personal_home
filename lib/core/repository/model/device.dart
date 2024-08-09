import 'package:equatable/equatable.dart';
import 'package:personal_home/core/entity/device.dart';

class DeviceModel extends Equatable {
  final int id;
  final String label;
  final String macAddress;
  final String ipv4Cidr;

  const DeviceModel({
    required this.id,
    required this.macAddress,
    required this.label,
    required this.ipv4Cidr,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json["id"] ?? 0,
      macAddress: json["mac_address"] ?? "",
      label: json["label"] ?? "",
      ipv4Cidr: json["ipv4_cidr"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac_address": macAddress,
        "label": label,
        "ipv4_cidr": ipv4Cidr,
      };

  @override
  List<Object?> get props => [
        id,
        macAddress,
        label,
        ipv4Cidr,
      ];

  DeviceEntity toEntity() {
    return DeviceEntity(
      id: id,
      macAddress: macAddress,
      label: label,
      ipv4Cidr: ipv4Cidr,
      status: false,
    );
  }
}
