import 'dart:io';

import 'package:fbeacon_finder/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconListItem extends StatelessWidget {
  final Beacon? beacon;
  const BeaconListItem({
    Key? key,
    required this.beacon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.purple,
      leading: const Icon(Icons.bubble_chart_rounded),
      title: Text(
          "${Platform.isIOS ? beacon?.proximityUUID : beacon?.macAddress}"),
      subtitle: Text("major: ${beacon?.major} minor: ${beacon?.minor}"),
      trailing: Text("${beacon?.rssi} dbm"),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.beaconDetail, arguments: beacon);
      },
    );
  }
}
