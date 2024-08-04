import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<DeviceBloc>(
          create: (context) => DeviceBloc(),
        ),
        // Add other BLoCs here if needed
      ];
}
