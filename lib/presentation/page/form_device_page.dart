import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';
import 'package:personal_home/core/entity/device.dart';

class FormDevicePage extends StatelessWidget {
  static const routeName = '/form-device';

  final TextEditingController _controllerMacAddress = TextEditingController();
  final TextEditingController _controllerLabel = TextEditingController();
  final TextEditingController _controllerIpv4 = TextEditingController();
  final TextEditingController _controllerIpv6 = TextEditingController();

  FormDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerMacAddress,
              decoration: const InputDecoration(labelText: 'Enter MAC Address'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controllerLabel,
              decoration: const InputDecoration(labelText: 'Enter Label'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controllerIpv4,
              decoration: const InputDecoration(labelText: 'Enter IPv4'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controllerIpv6,
              decoration: const InputDecoration(labelText: 'Enter IPv6'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controllerLabel.text.isEmpty &&
                    _controllerMacAddress.text.isEmpty &&
                    _controllerIpv4.text.isEmpty &&
                    _controllerIpv6.text.isEmpty) {
                  return;
                }
                final device = DeviceEntity(
                  id: 0,
                  macAddress: _controllerMacAddress.text,
                  label: _controllerLabel.text,
                  ipv4: _controllerIpv4.text,
                  ipv6: _controllerIpv6.text,
                  status: false,
                );
                BlocProvider.of<DeviceBloc>(context)
                    .add(DeviceEventInsert(device));
                Navigator.pop(context);
              },
              child: const Text('Add Data'),
            )
          ],
        ),
      ),
    );
  }
}
