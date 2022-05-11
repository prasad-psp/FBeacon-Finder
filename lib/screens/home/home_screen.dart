import 'package:fbeacon_finder/provider/beacon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'beacon_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _stopFinding();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beacon Finder"),
        centerTitle: true,
      ),
      body: Consumer<BeaconProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Column(
              children: [
                provider.progressVisible
                    ? const LinearProgressIndicator()
                    : const SizedBox(height: 0.0),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.beaconList?.length != null
                        ? provider.beaconList?.length
                        : 0,
                    itemBuilder: ((context, index) => BeaconListItem(
                        beacon: provider.beaconList?.elementAt(index))),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<BeaconProvider>(context, listen: false)
                  .findingProcessRunning
              ? _stopFinding()
              : _findBeacons();
        },
        child: Consumer<BeaconProvider>(builder: (context, provider, child) {
          return provider.findingProcessRunning
              ? const Icon(Icons.stop)
              : const Icon(Icons.search);
        }),
      ),
    );
  }

  _init() async {
    await Provider.of<BeaconProvider>(context, listen: false).init();
    _findBeacons();
  }

  _findBeacons() {
    Provider.of<BeaconProvider>(context, listen: false).start();
  }

  _stopFinding() {
    Provider.of<BeaconProvider>(context, listen: false).stop();
  }
}
