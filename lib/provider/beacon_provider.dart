import 'dart:async';

import 'package:fbeacon_finder/beacon/beacon_callbacks.dart';
import 'package:fbeacon_finder/beacon/beacon_finder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconProvider with ChangeNotifier implements RangingCallback {
  late BeaconFinder beaconFinder;

  bool _isInit = false;

  List<Beacon> beaconList = <Beacon>[];

  bool progressVisible = false;

  bool findingProcessRunning = false;

  late Timer _timer;

  Future<void> init() async {
    beaconFinder = BeaconFinder();
    _isInit = await beaconFinder.init();
    beaconFinder.setOnRangingListener(this);
    _print("init beacon");
  }

  void start() {
    if (_isInit) {
      beaconList.clear();
      progressVisible = true;
      findingProcessRunning = true;
      notifyListeners();

      beaconFinder.startRanging();
      _print("start beacon");
      _stopAutomatic();
    }
  }

  void _stopAutomatic() async {
    // **Stop beacon process after 20 sec
    _timer = Timer(const Duration(seconds: 20), (() => stop()));
  }

  void stop() {
    if (_isInit) {
      _timer.cancel();
      beaconFinder.stopRanging();
      _print("stop beacon");

      progressVisible = false;
      findingProcessRunning = false;
      notifyListeners();
    }
  }

  @override
  void beaconsFound(List<Beacon> beacons) {
    if (beacons.isNotEmpty) {

      for (Beacon b in beacons) {
        if (beaconList.contains(b)) {
          // **Already exists
          var index = beaconList.indexOf(b);
          beaconList[index] = b;
          _print("${beaconList.elementAt(index)}");
        } else {
          // **New beacon found
          beaconList.add(b);
        }
      }

      // **Check beacons added in list or not
      if (beaconList.isNotEmpty) {
        // **Beacons found
        notifyListeners();
      }
    }
  }

  @override
  void beaconsNotFound() {
    _print("beacon not found");
  }

  void _print(String msg) {
    print("Provider $msg");
  }
}
