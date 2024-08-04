import 'package:flutter/material.dart';

class AddDevicePage extends StatelessWidget {
  static const routeName = '/add-device';
  final TextEditingController _controllerMacAddress = TextEditingController();
  final TextEditingController _controllerIpv4 = TextEditingController();
  final TextEditingController _controllerIpv6 = TextEditingController();

  AddDevicePage({super.key});

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
                final data = _controllerMacAddress.text;
                if (data.isNotEmpty) {
                  // BlocProvider.of<DataBloc>(context).add(AddData(data));
                  // Navigator.pop(context);
                }
              },
              child: const Text('Add Data'),
            )
          ],
        ),
      ),
    );
  }
}
