
import 'package:flutter/material.dart';

class BeaconListItem extends StatelessWidget {
  const BeaconListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.bubble_chart_rounded),
      title: Text("dskjfhsjkdhfsdhfdshjkf"),
      subtitle: Text("major minor"),
      trailing: Text("-dsfk dbm"),
      onTap: () {},
    );
  }
}