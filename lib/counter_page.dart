import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final num = Provider<int>((ref) => 22);

class ProviderPage extends ConsumerWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Page"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, __) {
            final number = ref.watch(num).toString();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(number,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.green)),
              ],
            );
          },
        ),
      )),
    );
  }
}
