import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';

List<BlocProvider> registerBloc() {
  return [
    BlocProvider<DeviceBloc>(
      create: (context) {
        return DeviceBloc();
      },
    )
  ];
}
