// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_one/change_notifier.dart';
import 'package:riverpod_one/counter_page.dart';
import 'package:riverpod_one/modifiers/FamilyObject_modifier_page.dart';
import 'package:riverpod_one/modifiers/Familyprimitive_modifier_page.dart';
import 'package:riverpod_one/service/future_provider.dart';
import 'package:riverpod_one/state_notifier_provider.dart';

import 'modifiers/AutoDispose_modifier_page.dart';
import 'state_provider_page.dart';
import 'stream_provider_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        '/Provider': (context) => ProviderPage(),
        "/StateProvider": (context) => StateProviderPage(),
        '/FutureProvider': (context) => FutureProviderPage(),
        '/StreamProvider': (context) => StreamProviderPage(),
        '/StateNotifierP': (context) => StateNotifierPage(),
        '/ChangeNotifierP': (context) => ChangeNotifierPage(),
        '/FamilyPrimitiveModifierP': (context) => FamilyPrimitiveModifierPage(),
        '/FamilyObjectModifierP': (context) => FamilyObjectModifierPage(),
        '/AutoDisposeModifierP': (context) => AutoDisposeModifierPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  static const gap = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RiverPod",
          style: TextStyle(
              color: Colors.lightBlueAccent, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Center(child: buildPages(context)),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
              icon: Text(
                "Riverpod",
                style: TextStyle(color: Colors.blue),
              ),
              label: "Providers",
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Text(
                "Riverpod",
                style: TextStyle(color: Colors.blue),
              ),
              label: "Notifiers",
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Text(
                "Riverpod",
                style: TextStyle(color: Colors.blue),
              ),
              label: "Modifiers",
              backgroundColor: Colors.blueGrey),
        ],
        onTap: (int index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }

  Widget buildPages(context) {
    switch (index) {
      case 0:
        return buildProvidersPage(context);
      case 1:
        return buildNotifiersPage(context);
      case 2:
        return buildModifiersPage(context);
      default:
        return Container();
    }
  }

  Widget buildProvidersPage(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/Provider"),
              child: const Text("ProviderPage"),
            ),
            gap,
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/StateProvider"),
                child: Text("StateProviderPage")),
            gap,
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/FutureProvider"),
                child: Text("FutureProviderPage")),
            gap,
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/StreamProvider"),
                child: Text("StreamProviderPage"))
          ],
        ),
      );

  Widget buildNotifiersPage(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text("StateNotifierProvider"),
              onPressed: () => navigateTo(context, "/StateNotifierP")),
          gap,
          ElevatedButton(
              child: Text("ChangeNotifierProvider"),
              onPressed: () => navigateTo(context, "/ChangeNotifierP")),
        ],
      );

  void navigateTo(BuildContext context, String page) =>
      Navigator.of(context).pushNamed(page);

  Widget buildModifiersPage(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text('Family Primitive'),
          onPressed: () => navigateTo(context, '/FamilyPrimitiveModifierP'),
        ),
        gap,
        ElevatedButton(
          child: Text('Family Object'),
          onPressed: () => navigateTo(context, '/FamilyObjectModifierP'),
        ),
        gap,
        ElevatedButton(
          child: Text('Auto-Dispose'),
          onPressed: () => navigateTo(context, '/AutoDisposeModifierP'),
        )
      ],
    );
  }
}
