import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  DeviceEntity({
    required this.id,
    required this.ipv4,
    required this.ipv6,
    required this.macAddress,
  });

  late int id;
  late String ipv4;
  late String ipv6;
  late String macAddress;

  factory DeviceEntity.fromJson(Map<String, dynamic> json){
    return DeviceEntity(
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
    id, ipv4, ipv6, macAddress, ];
}
