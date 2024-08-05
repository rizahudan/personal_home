part of 'device_bloc.dart';

sealed class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class DeviceEventGetList extends DeviceEvent {}

class DeviceEventInsert extends DeviceEvent {
  final DeviceEntity device;

  const DeviceEventInsert(this.device);

  @override
  List<Object> get props => [device];
}
