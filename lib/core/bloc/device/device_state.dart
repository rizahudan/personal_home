part of 'device_bloc.dart';

sealed class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

final class DeviceStateInitial extends DeviceState {}

final class DeviceStateLoading extends DeviceState {}

final class DeviceStateLoaded extends DeviceState {
  final List<DeviceEntity> devices;

  const DeviceStateLoaded({required this.devices});

  @override
  List<Object> get props => [devices];
}

final class DeviceStateSuccess extends DeviceState {}
