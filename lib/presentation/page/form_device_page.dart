import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/utils/ui/snackbar_utils.dart';

class FormDevicePage extends StatelessWidget {
  static const routeName = '/form-device';

  final TextEditingController _controllerMacAddress = TextEditingController();
  final TextEditingController _controllerLabel = TextEditingController();
  final TextEditingController _controllerIpv4 = TextEditingController();
  final TextEditingController _controllerCidrIpv4 = TextEditingController();

  FormDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<DeviceBloc>(context),
        child: BlocListener<DeviceBloc, DeviceState>(
          listener: (context, state) {
            if (state is DeviceStateSuccess) {
              showSuccessSnackBar(context);
              Navigator.of(context).pop(); // Close the dialog if success
            } else if (state is DeviceStateFailure) {
              showFailureSnackBar(context);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Device'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controllerMacAddress,
                    decoration:
                        const InputDecoration(labelText: 'Enter MAC Address'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controllerLabel,
                    decoration: const InputDecoration(labelText: 'Enter Label'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllerIpv4,
                          decoration:
                              const InputDecoration(labelText: 'Enter IPv4'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ),
                        height: 56.0, // Add padding if needed
                        child: const Text(
                          '/',
                          style: TextStyle(
                            fontSize: 56.0,
                          ),
                        ), // This should match the height of the TextField
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controllerCidrIpv4,
                          decoration:
                              const InputDecoration(labelText: 'Enter CIDR'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                2), // Limit input to 2 characters
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_controllerLabel.text.isEmpty &&
                          _controllerMacAddress.text.isEmpty &&
                          _controllerIpv4.text.isEmpty) {
                        return;
                      }
                      final device = DeviceEntity(
                        id: 0,
                        macAddress: _controllerMacAddress.text,
                        label: _controllerLabel.text,
                        ipv4Cidr:
                            '${_controllerIpv4.text}/${_controllerCidrIpv4.text}',
                        status: false,
                      );
                      BlocProvider.of<DeviceBloc>(context)
                          .add(DeviceEventInsert(device));
                    },
                    child: const Text('Add Data'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
