import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_home/core/bloc/provider.dart';
import 'package:personal_home/core/config/config.dart';
import 'package:personal_home/core/dependency_injection.dart';
import 'package:personal_home/presentation/page/home_page.dart';
import 'package:personal_home/presentation/route.dart';
import 'package:personal_home/presentation/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = await newConfig();
  await setupLocator(config);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        title: 'Flutter BLoC Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
        ),
        themeMode: ThemeMode.dark,
        navigatorObservers: [routeObserver],
        initialRoute: HomePage.routeName,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
