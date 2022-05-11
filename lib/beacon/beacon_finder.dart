import 'dart:async';
import 'dart:io';
import 'package:fbeacon_finder/beacon/beacon_callbacks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class BeaconFinder {
  StreamSubscription<RangingResult>? _streamRanging;
  StreamSubscription<MonitoringResult>? _streamMonitoring;
  final _regions = <Region>[];

  RangingCallback? _rangingCallback;
  MonitoringCallback? _monitoringCallback;

  Future<bool> init() async {
    try {
      // or if you want to include automatic checking permission
      return await flutterBeacon.initializeAndCheckScanning
          ? _initRegion()
          : false;
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      _printmsg("Init Error " + e.message.toString());
      return false;
    }
  }

  bool _initRegion() {
    // initialize region
    if (Platform.isIOS) {
      // iOS platform, at least set identifier and proximityUUID for region scanning
      _regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    } else {
      // android platform, it can ranging out of beacon that filter all of Proximity UUID
      _regions.add(Region(identifier: 'com.beacon'));
    }

    return true;
  }

  void setOnRangingListener(RangingCallback rangingCallback) {
    _rangingCallback = rangingCallback;
  }

  void setOnMonitoringListener(MonitoringCallback monitoringCallback) {
    _monitoringCallback = monitoringCallback;
  }

  void startAll() {
    startRanging();
    startMonitoring();
    _printmsg("start all");
  }

  void stopAll() {
    stopRanging();
    stopMonitoring();
    _printmsg("stop all");
  }

  void startRanging() {
    _printmsg("start region");
    // to start ranging beacons
    _streamRanging =
        flutterBeacon.ranging(_regions).listen((RangingResult result) {
      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
      var list = result.beacons;
      if (list.isNotEmpty) {
        _rangingCallback?.beaconsFound(list);
      } else {
        _rangingCallback?.beaconsNotFound();
      }
    });
  }

  void stopRanging() {
    // to stop ranging beacons
    _streamRanging?.cancel();
    _printmsg("stop ranging");
  }

  void startMonitoring() {
    _printmsg("start monitoring");
    // to start monitoring beacons
    _streamMonitoring =
        flutterBeacon.monitoring(_regions).listen((MonitoringResult result) {
      // result contains a region, event type and event state
      _monitoringCallback?.onMonitoringStateChanged(
          result.monitoringEventType, result.monitoringState);
    });
  }

  void stopMonitoring() {
    // to stop monitoring beacons
    _streamMonitoring?.cancel();
    _printmsg("stop monitoring");
  }
}

void _printmsg(String msg) {
  print("PSP " + msg);
}
