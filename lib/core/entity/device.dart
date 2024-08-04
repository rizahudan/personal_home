import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final int id;
  final String ipv4;
  final String ipv6;
  final String macAddress;
  final bool status;

  const DeviceEntity({
    required this.id,
    required this.ipv4,
    required this.ipv6,
    required this.macAddress,
    required this.status,
  });

  // Method to create a new instance with a modified name
  DeviceEntity copyWith({
    int? id,
    String? ipv4,
    String? ipv6,
    String? macAddress,
    bool? status,
  }) {
    return DeviceEntity(
      id: id ?? this.id,
      ipv4: ipv4 ?? this.ipv4,
      ipv6: ipv6 ?? this.ipv6,
      macAddress: macAddress ?? this.macAddress,
      status: status ?? this.status,
    );
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json["id"] ?? 0,
      ipv4: json["ipv4"] ?? "",
      ipv6: json["ipv6"] ?? "",
      macAddress: json["mac_address"] ?? "",
      status: json["status"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ipv4": ipv4,
        "ipv6": ipv6,
        "mac_address": macAddress,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        ipv4,
        ipv6,
        macAddress,
        status,
      ];
}
