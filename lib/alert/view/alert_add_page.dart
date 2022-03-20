// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_traffic_976/counter/counter.dart';
import 'package:info_traffic_976/l10n/l10n.dart';
import 'package:latlong2/latlong.dart';

class AlertAddPage extends StatelessWidget {
  const AlertAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const AlertAddView(),
    );
  }
}

class AlertAddView extends StatelessWidget {
  const AlertAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: const Center(child: GridLayout()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class GridLayout extends StatelessWidget {
  const GridLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(10, (index) {
      return Center(
        child: Text(
          'Item $index',
          style: Theme.of(context).textTheme.headline5,
        ),
      );
    }),
    );}
}
