import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchNumber = StateProvider.autoDispose((_) => 0);

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gap = SizedBox(height: 10);
    const gap2 = SizedBox(height: 20);

    final num = ref.watch(watchNumber.state);
    int number = ref.watch(watchNumber);
    // ref.listen<StateController<int>>(watchNumber, (value) => print("$value"));
    return Scaffold(
        appBar: AppBar(
            title: Text("StateProviderPage"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              color: Colors.green,
              hoverColor: Colors.greenAccent,
              tooltip: "Back",
            )),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(number.toString(),
                style: Theme.of(context).textTheme.displayLarge)
          ]),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () => (num.state > 0) ? num.state-- : num.state,
                child: Icon(Icons.remove)),
            gap2,
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => num.state++,
              backgroundColor: Colors.deepOrange,
            ),
          ],
        ));
  }
}
