import 'package:flutter/material.dart';

class BeaconDetailScreen extends StatelessWidget {
  const BeaconDetailScreen({Key? key}) : super(key: key);

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
              Text("sdfdsfdsfsdfsdfsdfdsfsfs"),
              spacingWidget(),
              headingWidget("BT Address"),
              Text("sdfdsfdsfsdfsdfsdfdsfsfs"),
              spacingWidget(),
              headingWidget("Major Minor"),
              Text("sdfdsfdsfsdfsdfsdfdsfsfs"),
              spacingWidget(),
              headingWidget("Distance"),
              Text("1.2 m"),
              spacingWidget(),
              headingWidget("Tx Power"),
              Text("-54 m "),
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
