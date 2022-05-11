import 'package:flutter_beacon/flutter_beacon.dart';

class RangingCallback {
  void beaconsFound(List<Beacon> beacons) {}
  void beaconsNotFound() {}
}

class MonitoringCallback {
  void onMonitoringStateChanged(MonitoringEventType monitoringEventType,
      MonitoringState? monitoringState) {}
}
