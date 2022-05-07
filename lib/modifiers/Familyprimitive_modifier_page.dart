import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_one/modifiers/service.dart';

import '../widget/user_widget.dart';
import 'user_helper.dart';

Future<List<Users>> users = fetchData();

Future<Users> fetchUser(Future<String> username) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return users
      .then((users) => users.firstWhere((user) => user.username == username));
}

final userProvider = FutureProvider.family<Users, Future<String>>(
    (ref, Future<String> username) async {
  return fetchUser(username);
});

class FamilyPrimitiveModifierPage extends StatefulWidget {
  const FamilyPrimitiveModifierPage({Key? key}) : super(key: key);

  @override
  State<FamilyPrimitiveModifierPage> createState() =>
      _FamilyPrimitiveModifierPageState();
}

class _FamilyPrimitiveModifierPageState
    extends State<FamilyPrimitiveModifierPage> {
  static const gap = SizedBox(height: 10);

  Future<String> username = users.then((users) => users.first.username);
  @override
  Widget build(BuildContext context) {
    debugPrint(users == null ? 'null' : "not null");
    return Scaffold(
        appBar: AppBar(
          title: Text("FamilyPrimitive Modifier"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 300,
                // width: double.infinity,
                child: Consumer(
                  builder: (context, WidgetRef ref, child) {
                    final future = ref.watch(userProvider(username));
                    return future.when(
                        data: (user) => UserWidget(user: user),
                        error: (err, stack) => Text(
                              "Error: $err",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                        loading: () => const CircularProgressIndicator());
                  },
                )),
            gap,
            buildSearch(),
          ]),
        ));
  }

  Widget buildSearch() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildUsernameDropdown(),
          ],
        ),
      );

  Widget buildUsernameDropdown() => Row(children: [
        Text(
          'Username',
          style: TextStyle(fontSize: 24),
        ),
        const Spacer(),
        FutureBuilder<List<Users>>(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButton<String>(
                  items: snapshot.data
                      ?.map((user) => DropdownMenuItem<String>(
                            child: Text(user.username),
                            value: user.username,
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      snapshot.data?.first.username = newValue!;
                    });
                  },
                  hint: Text("Select"),
                  value: snapshot.data?.first.username,
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
      ]);
}
