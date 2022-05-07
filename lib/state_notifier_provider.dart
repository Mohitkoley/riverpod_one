import 'dart:math';

import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Car {
  const Car({this.doors = 4, this.speed = 120});

  final int doors;
  final int speed;

  Car copy({required int speed, required int doors}) =>
      Car(speed: speed, doors: doors);
}

class CarNotifier extends StateNotifier<Car> {
  CarNotifier() : super(const Car());

  void setDoors(int doors) {
    final newState = state.copy(doors: doors, speed: state.speed);
    state = newState;
  }

  void increaseSpeed() {
    final speed = state.speed + 5;
    final newState = state.copy(speed: speed, doors: state.doors);
    state = newState;
  }

  void hitBreak() {
    final speed = max(0, state.speed - 30);
    final newState = state.copy(speed: speed, doors: state.doors);
    state = newState;
  }

  void dispose() {
    super.dispose();
  }
}

final stateNotifierProvider = StateNotifierProvider((ref) => CarNotifier());

class StateNotifierPage extends ConsumerWidget {
  const StateNotifierPage({Key? key}) : super(key: key);

  static const gap = SizedBox(height: 10);

  Widget buildButtons(BuildContext context, WidgetRef ref) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () =>
                ref.read(stateNotifierProvider.notifier).increaseSpeed(),
            child: Text("Increase +5"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green))),
        gap,
        ElevatedButton(
            onPressed: () =>
                ref.read(stateNotifierProvider.notifier).hitBreak(),
            child: Text("Hit Break -30"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red))),
      ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carNotifier = ref.watch(stateNotifierProvider);

    final car = ref.watch(stateNotifierProvider.notifier);
    final speed = car.state.speed;
    final doors = car.state.doors;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Speed: $speed", style: TextStyle(fontSize: 30)),
          gap,
          Text("Doors: $doors", style: TextStyle(fontSize: 30)),
          gap,
          buildButtons(context, ref),
          Slider(
            value: speed.toDouble(),
            min: 0,
            max: 5,
            onChanged: (value) => car.setDoors(value.toInt()),
          )
        ]),
      ),
    );
  }
}
