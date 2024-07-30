import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/dependency_injection.dart';
import 'package:personal_home/core/service/service.dart';
import 'package:meta/meta.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceService _deviceService = locator.get<DeviceService>();

  DeviceBloc() : super(DeviceInitial()) {
    on<DeviceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
