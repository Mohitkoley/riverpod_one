import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarNotifier extends ChangeNotifier {
  int _speed = 120;

  void increase() {
    _speed += 5;
    notifyListeners();
  }

  void hitBreak() {
    _speed = max(0, _speed - 30);
    notifyListeners();
  }
}

final carProvider = ChangeNotifierProvider<CarNotifier>((ref) => CarNotifier());

class ChangeNotifierPage extends ConsumerWidget {
  static const gap = SizedBox(height: 10);
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CarNotifier car = ref.watch(carProvider);
    return Scaffold(
      appBar: AppBar(title: Text("ChangeNotifier"), centerTitle: true),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Speed: ${car._speed}", style: TextStyle(fontSize: 30)),
          gap,
          buildButtons(context, ref),
        ]),
      ),
    );
  }

  Widget buildButtons(BuildContext context, WidgetRef ref) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () => ref.read(carProvider).increase(),
            child: Text("Increase +5"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green))),
        gap,
        ElevatedButton(
            onPressed: () => ref.read(carProvider).hitBreak(),
            child: Text("Hit Break -30"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red))),
      ]);
}
