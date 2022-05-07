import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_one/model/model.dart';
import 'package:riverpod_one/service/service.dart';

final watchUser = FutureProvider.autoDispose<List<User>>((ref) async {
  return Service().fetchData();
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<User>> data = ref.watch(watchUser);
    return Scaffold(
        appBar: AppBar(
          title: Text("API using FutureProvider"),
          centerTitle: true,
        ),
        body: data.when(
            data: (value) => ListView.builder(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  User user = value[index];
                  return ListTile(
                    leading: Text(user.id.toString()),
                    subtitle: Text(user.body),
                    title: Text(user.title),
                    trailing: Text(user.userId.toString()),
                  );
                }),
            error: (error, stack) => Center(
                child: Text('Error: $error',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.red))),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
