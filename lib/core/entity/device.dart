import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final int id;
  final String macAddress;
  final String label;
  final String ipv4Cidr;
  final bool status;
  final String ipv4;
  final String broadcastIpv4;

  DeviceEntity({
    required this.id,
    required this.macAddress,
    required this.label,
    required this.ipv4Cidr,
    required this.status,
  })  : ipv4 = getIpv4(ipv4Cidr),
        broadcastIpv4 = getBrodcastIpv4(ipv4Cidr);

  // Method to create a new instance with a modified name
  DeviceEntity copyWith({
    int? id,
    String? macAddress,
    String? label,
    String? ipv4Cidr,
    bool? status,
  }) {
    return DeviceEntity(
      id: id ?? this.id,
      macAddress: macAddress ?? this.macAddress,
      label: label ?? this.label,
      ipv4Cidr: ipv4Cidr ?? this.ipv4Cidr,
      status: status ?? this.status,
    );
  }

  factory DeviceEntity.empty() {
    return DeviceEntity(
      id: 0,
      macAddress: '',
      label: '',
      ipv4Cidr: '',
      status: false,
    );
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json["id"] ?? 0,
      macAddress: json["mac_address"] ?? "",
      label: json["label"] ?? "",
      ipv4Cidr: json["ipv4_cidr"] ?? "",
      status: json["status"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac_address": macAddress,
        "label": label,
        "ipv4_cidr": ipv4,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        macAddress,
        label,
        ipv4Cidr,
        status,
      ];

  static String getIpv4(String ipv4AdressWithCidr) {
    if (ipv4AdressWithCidr.isEmpty) {
      return "";
    }
    List<String> addressParts = ipv4AdressWithCidr.split('/');
    return addressParts[0];
  }

  static String getBrodcastIpv4(String ipv4AdressWithCidr) {
    if (ipv4AdressWithCidr.isEmpty) {
      return "";
    }

    String ip = "";
    String cidr = '24';
    List<String> addressParts = ipv4AdressWithCidr.split('/');
    ip = addressParts[0];
    if (addressParts.length > 1 && addressParts[1].isNotEmpty) {
      cidr = addressParts[1];
    }

    int prefixLength = int.parse(cidr);

    // Convert the IP address to a 32-bit integer
    List<int> ipParts = ip.split('.').map(int.parse).toList();
    int ipAsInt = (ipParts[0] << 24) |
        (ipParts[1] << 16) |
        (ipParts[2] << 8) |
        ipParts[3];

    // Calculate the subnet mask as a 32-bit integer
    int subnetMask = ((1 << prefixLength) - 1) << (32 - prefixLength);

    // Calculate the broadcast address by setting all host bits to 1
    int broadcastAsInt = ipAsInt | ~subnetMask;

    // Convert the broadcast address back to dotted-decimal format
    List<String> broadcastParts = [
      ((broadcastAsInt >> 24) & 0xFF).toString(),
      ((broadcastAsInt >> 16) & 0xFF).toString(),
      ((broadcastAsInt >> 8) & 0xFF).toString(),
      (broadcastAsInt & 0xFF).toString(),
    ];

    return broadcastParts.join('.');
  }
}
