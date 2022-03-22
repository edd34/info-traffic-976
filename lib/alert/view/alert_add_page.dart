import 'package:flutter/material.dart';
import 'package:info_traffic_976/alert/view/alert_grid_layout.dart';
import 'package:info_traffic_976/l10n/l10n.dart';


class AlertAddPage extends StatelessWidget {
  const AlertAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return const Scaffold(
      body: Center(child: GridLayout()),
    );
  }
}
