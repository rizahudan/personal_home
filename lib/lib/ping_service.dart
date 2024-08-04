import 'dart:async';
import 'dart:developer';

import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';

class PingService {
  final String ipAddress;
  final int interval;
  final StreamController<bool> _pingController = StreamController<bool>();

  PingService({required this.ipAddress, this.interval = 1});

  Stream<bool> get pingStream => _pingController.stream;

  void startPinging() {
    Timer.periodic(Duration(seconds: interval), (timer) async {
      final result = await ping(ipAddress);
      _pingController.add(result);
    });
  }

  Future<bool> ping(String ipAddress) async {
    try {
      final ping = Ping(ipAddress, count: 1);
      final response = await ping.stream.first;
      if (response.error != null) {
        log('Ping to $ipAddress failed: ${response.error}');
        return false;
      } else {
        log('Ping to $ipAddress succeeded: ${response.response!.time!.inMilliseconds}ms');
        return true;
      }
    } catch (e) {
      log('Error pinging $ipAddress: $e');
      return false;
    }
  }

  void dispose() {
    _pingController.close();
  }
}
