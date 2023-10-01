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

enum Action {
  rotateLeft,
  rotateRight,
  moreVisible,
  lessVisible,
}

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({required this.rotationDeg, required this.alpha});
  const State.zero()
      : rotationDeg = 0.0,
        alpha = 1.0;
  State rotateRight() => State(
        alpha: alpha,
        rotationDeg: rotationDeg + 10.0,
      );
  State rotateLeft() => State(
        alpha: alpha,
        rotationDeg: rotationDeg - 10.0,
      );
  State increaseAlpha() => State(
        alpha: min(alpha + 0.1, 1.0),
        rotationDeg: rotationDeg,
      );
  State decreaseAlpha() => State(
        alpha: max(alpha - 0.1, 0.0),
        rotationDeg: rotationDeg,
      );
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case null:
      return oldState;
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              RotateLeftButton(store: store),
              RotateRightButton(store: store),
              DecreaseAlphaButton(store: store),
              IncreaseAlphaButton(store: store)
            ],
          ),
          const SizedBox(
            height: 100.0,
          ),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(
                  store.state.rotationDeg / 360.0,
                ),
                child: Image.network(url)),
          )
        ],
      ),
    );
  }
}

class IncreaseAlphaButton extends StatelessWidget {
  const IncreaseAlphaButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.moreVisible);
      },
      child: const Text('+ Alpha'),
    );
  }
}

class DecreaseAlphaButton extends StatelessWidget {
  const DecreaseAlphaButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.lessVisible);
      },
      child: const Text('- Alpha'),
    );
  }
}

class RotateRightButton extends StatelessWidget {
  const RotateRightButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateRight);
      },
      child: const Text('Rotate right'),
    );
  }
}

class RotateLeftButton extends StatelessWidget {
  const RotateLeftButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        store.dispatch(Action.rotateLeft);
      },
      child: const Text('Rotate left'),
    );
  }
}
