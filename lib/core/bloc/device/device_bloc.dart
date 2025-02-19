import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_home/core/entity/device.dart';
import 'package:personal_home/core/service/service.dart';
import 'package:personal_home/core/utils/dependency_injection.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceService _deviceService = locator.get<DeviceService>();

  DeviceBloc() : super(DeviceStateInitial()) {
    on<DeviceEventGetList>(_onGetList);
    on<DeviceEventInsert>(_onInsert);
    on<DeviceEventDelete>(_onDelete);
  }

  void _onGetList(DeviceEventGetList event, Emitter<DeviceState> emit) async {
    emit(DeviceStateLoading());
    final list = await _deviceService.getList();
    emit(DeviceStateLoaded(devices: list));
  }

  void _onInsert(DeviceEventInsert event, Emitter<DeviceState> emit) async {
    emit(DeviceStateLoading());
    await _deviceService.insert(event.device);
    emit(DeviceStateSuccess());
  }

  void _onDelete(DeviceEventDelete event, Emitter<DeviceState> emit) async {
    emit(DeviceStateLoading());

    try {
      await _deviceService.delete(event.id);
      emit(DeviceStateSuccess());
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      emit(DeviceStateFailure());
    }
  }
}
