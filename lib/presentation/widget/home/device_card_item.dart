import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/lib/ping_service.dart';

class DeviceCardItem extends StatefulWidget {
  final DeviceEntity device;
  const DeviceCardItem({super.key, required this.device});

  @override
  State<DeviceCardItem> createState() => _DeviceCardItemState();
}

class _DeviceCardItemState extends State<DeviceCardItem> {
  late DeviceEntity _device;
  late PingService _pingService;
  late Stream<bool> _pingStream;

  @override
  void initState() {
    super.initState();
    _device = widget.device;
    _pingService = PingService(
      ipAddress: _device.ipv4,
      interval: 5,
    );
    _pingStream = _pingService.pingStream;
    _pingService.startPinging();
    _pingStream.listen((accessible) {
      setState(() {
        _device = widget.device.copyWith(status: accessible);
      });
    });
  }

  @override
  void dispose() {
    _pingService.dispose();
    super.dispose();
  }

  void _onTapCard() {
    print("card");
  }

  void _onPressedWake() {
    print("wake");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: _onTapCard,
        child: Card(
          elevation: 10, // Adjust the elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Adjust the border radius as needed
            side: BorderSide(
              color: _device.status
                  ? Colors.green
                  : Colors.red, // Set the border color here
              width: 5.0, // Set the border width here
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("${_device.macAddress} (${_device.label})"),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("IPv4"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(_device.ipv4),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("IPv6"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(_device.ipv6),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: _onPressedWake,
                    child: const Text('Wake'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
