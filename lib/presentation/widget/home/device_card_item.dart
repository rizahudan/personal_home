import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/lib/ping_service.dart';

enum _CardAction { edit, delete }

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

  void _onCardActionSelected(_CardAction value) {
    if (value == _CardAction.edit) {
    } else if (value == _CardAction.delete) {
      _showDeleteConfirmation();
    }
  }

  Future _showDeleteConfirmation() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<DeviceBloc>(context),
          child: BlocListener<DeviceBloc, DeviceState>(
            listener: (context, state) {
              if (state is DeviceStateSuccess) {
                Navigator.of(context).pop(); // Close the dialog if success
              }
            },
            child: AlertDialog(
              title: const Text('Confirm Action'),
              content: Text(
                  'Do you want to proceed ${_device.macAddress} (${_device.label})?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<DeviceBloc>(context)
                        .add(DeviceEventDelete(_device.id));
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                trailing: PopupMenuButton<_CardAction>(
                  onSelected: _onCardActionSelected,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<_CardAction>>[
                      const PopupMenuItem<_CardAction>(
                        value: _CardAction.edit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Edit'),
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuItem<_CardAction>(
                        value: _CardAction.delete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delete'),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
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
