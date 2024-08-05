import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final int id;
  final String macAddress;
  final String label;
  final String ipv4;
  final String ipv6;
  final bool status;

  const DeviceEntity({
    required this.id,
    required this.macAddress,
    required this.label,
    required this.ipv4,
    required this.ipv6,
    required this.status,
  });

  // Method to create a new instance with a modified name
  DeviceEntity copyWith({
    int? id,
    String? macAddress,
    String? label,
    String? ipv4,
    String? ipv6,
    bool? status,
  }) {
    return DeviceEntity(
      id: id ?? this.id,
      macAddress: macAddress ?? this.macAddress,
      label: label ?? this.label,
      ipv4: ipv4 ?? this.ipv4,
      ipv6: ipv6 ?? this.ipv6,
      status: status ?? this.status,
    );
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json["id"] ?? 0,
      macAddress: json["mac_address"] ?? "",
      label: json["label"] ?? "",
      ipv4: json["ipv4"] ?? "",
      ipv6: json["ipv6"] ?? "",
      status: json["status"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac_address": macAddress,
        "label": label,
        "ipv4": ipv4,
        "ipv6": ipv6,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        macAddress,
        label,
        ipv4,
        ipv6,
        status,
      ];
}
