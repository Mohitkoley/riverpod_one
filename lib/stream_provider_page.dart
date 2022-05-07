import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider.autoDispose<String>(
    (ref) => Stream.periodic(Duration(seconds: 1), (count) => "$count"));

class StreamProviderPage extends ConsumerWidget {
  const StreamProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StreamProvider"),
        centerTitle: true,
      ),
      body: Center(child: buildStreamWhen(context, ref)),
    );
  }

  Widget buildStreamWhen(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(streamProvider);
    return stream.when(
      data: (value) => Text(value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.green, fontSize: 30)),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text("Error: $err"),
    );
  }
}
