import 'package:fbeacon_finder/beacon/beacon_callbacks.dart';
import 'package:fbeacon_finder/beacon/beacon_finder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconProvider with ChangeNotifier implements RangingCallback {
  late BeaconFinder beaconFinder;

  bool isInit = false;

  List<Beacon>? beaconList;

  bool progressVisible = false;

  bool findingProcessRunning = false;

  Future<void> init() async {
    beaconFinder = BeaconFinder();
    isInit = await beaconFinder.init();
    beaconFinder.setOnRangingListener(this);
    _print("init beacon");
  }

  void start() {
    if (isInit) {
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
    await Future.delayed(const Duration(seconds: 10), (() => stop()));
  }

  void stop() {
    if (isInit) {
      beaconFinder.stopRanging();
      _print("stop beacon");

      progressVisible = false;
      findingProcessRunning = false;
      notifyListeners();
      beaconList = null;
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