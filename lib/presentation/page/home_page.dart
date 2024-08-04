import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/device/device_bloc.dart';
import 'package:personal_home/presentation/page/add_device_page.dart';
import 'package:personal_home/presentation/widget/home/device_card_item.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // init get data on first time loaded
    BlocProvider.of<DeviceBloc>(context).add(
      DeviceEventGetList(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            return const Center(child: Text('initial.'));
          } else if (state is DeviceStateLoading) {
            return const Center(child: Text('loading.'));
          } else if (state is DeviceStateLoaded) {
            return ListView.builder(
              itemCount: state.devices.length,
              itemBuilder: (context, index) {
                return DeviceCardItem(device: state.devices[index]);
              },
            );
          }
          // if (state is DataInitial) {
          //   return const Center(child: Text('No data available.'));
          // } else if (state is DataLoaded) {
          //   return ListView.builder(
          //     itemCount: state.data.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(state.data[index]),
          //       );
          //     },
          //   );
          // }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddDevicePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
