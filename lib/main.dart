import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

const url = 'https://bit.ly/46oBQFe';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLifecycleState lifecycle;
    final state = useAppLifecycleState();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: state == AppLifecycleState.resumed ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withAlpha(100),
                      spreadRadius: 10)
                ],
              ),
              child: Image.asset('assets/card.webp'),
            ),
          ),
        ));
  }
}
