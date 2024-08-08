import 'package:get_it/get_it.dart';
import 'package:personal_home/core/config/config.dart';
import 'package:personal_home/core/repository/device.dart';
import 'package:personal_home/core/service/service.dart';

import '../adapter/database/sqlite.dart';

final locator = GetIt.instance;

Future<void> setupLocator(Config cfg) async {
  final sqliteConf = SqliteConfig(
    dbName: cfg.database!.sqlite!.dbName,
  );
  final sqlite = SqliteAdapter(sqliteConf);

  final deviceRepo = DeviceRepository(sqlite);

  locator.registerLazySingleton(() => DeviceService(deviceRepo));
}
