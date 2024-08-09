import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';
import 'package:personal_home/navigation/route_observer.dart';
import 'package:personal_home/presentation/page/form_device_page.dart';
import 'package:personal_home/presentation/widget/home/device_card_item.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();

    // init get data on first time loaded
    _getDeviceList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _getDeviceList();
  }

  void _getDeviceList() {
    BlocProvider.of<DeviceBloc>(context).add(
      DeviceEventGetList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceStateInitial) {
            return const Center(child: Text('initial'));
          } else if (state is DeviceStateLoading) {
            return const Center(child: Text('loading'));
          } else if (state is DeviceStateLoaded) {
            if (state.devices.isEmpty) {
              return const Center(child: Text('No Data'));
            }

            return ListView.builder(
              itemCount: state.devices.length,
              itemBuilder: (context, index) {
                return DeviceCardItem(device: state.devices[index]);
              },
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FormDevicePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
