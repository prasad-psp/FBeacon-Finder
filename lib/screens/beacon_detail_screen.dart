import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconDetailScreen extends StatelessWidget {
  final Beacon? beacon;

  const BeaconDetailScreen({Key? key, required this.beacon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beacon details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headingWidget("UUID"),
              Text("${beacon?.proximityUUID.toString()}"),
              spacingWidget(),
              headingWidget("BT Address"),
              Text("${Platform.isAndroid ? beacon?.macAddress : " "}"),
              spacingWidget(),
              headingWidget("Major Minor"),
              Text("${beacon?.major.toString()} ${beacon?.minor.toString()}"),
              spacingWidget(),
              headingWidget("Distance"),
              Text("${beacon?.accuracy.toString()} m"),
              spacingWidget(),
              headingWidget("Tx Power"),
              Text("${Platform.isAndroid ? beacon?.txPower : ""}"),
              spacingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget spacingWidget() => const SizedBox(
      height: 15.0,
    );

Widget headingWidget(String heading) => Text(
      heading,
      textScaleFactor: 1.1,
    );
