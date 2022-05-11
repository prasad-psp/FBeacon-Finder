import 'package:fbeacon_finder/provider/beacon_provider.dart';
import 'package:fbeacon_finder/route/app_routes.dart';
import 'package:fbeacon_finder/screens/beacon_detail_screen.dart';
import 'package:fbeacon_finder/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BeaconProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FBeacon Finder",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case AppRoutes.initialRoute:
            {
              return MaterialPageRoute(
                  builder: (context) => const HomeScreen());
            }
          case AppRoutes.beaconDetail:
            {
              return MaterialPageRoute(
                  builder: (context) =>
                      BeaconDetailScreen(beacon: setting.arguments as Beacon));
            }
        }
      },
    );
  }
}
