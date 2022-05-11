import 'dart:async';

import 'package:fbeacon_finder/beacon/beacon_callbacks.dart';
import 'package:fbeacon_finder/beacon/beacon_finder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconProvider with ChangeNotifier implements RangingCallback {
  late BeaconFinder beaconFinder;

  bool _isInit = false;

  List<Beacon>? beaconList;

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
      beaconList = null;
      progressVisible = true;
      findingProcessRunning = true;
      notifyListeners();

      beaconFinder.startRanging();
      _print("start beacon");
      _stopAutomatic();
    }
  }

  void _stopAutomatic() async {
    _print("Stop after 10 sec beacon");
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
      beaconList = beacons;
      notifyListeners();
      _print("beacon found");
    }
  }

  @override
  void beaconsNotFound() {
    _print("beacon not found");
  }

  void _print(String msg) {
    print("PSP Provider $msg");
  }
}
