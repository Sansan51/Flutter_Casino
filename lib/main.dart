import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casino',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CasinoPage(),
    );
  }
}

class CasinoPage extends StatefulWidget {
  const CasinoPage({Key? key}) : super(key: key);

  @override
  CasinoPageState createState() => CasinoPageState();
}

class CasinoPageState extends State<CasinoPage> {
  final List<String> _icons = [
    'images/bar.png',
    'images/cerise.png',
    'images/cloche.png',
    'images/diamant.png',
    'images/fer-a-cheval.png',
    'images/pasteque.png',
    'images/sept.png',
  ];

  List<int> _selectedIndexes = [0, 0, 0];

  void _spin() {
    setState(() {
      _selectedIndexes = [
        Random().nextInt(_icons.length),
        Random().nextInt(_icons.length),
        Random().nextInt(_icons.length),
      ];
    });
  }

  bool _isJackpot() {
    return _selectedIndexes[0] == _selectedIndexes[1] &&
        _selectedIndexes[0] == _selectedIndexes[2];
  }

  bool _isJackpotWithSeven() {
    return _isJackpot() && _selectedIndexes[0] == 6;
  }

  @override
  Widget build(BuildContext context) {
    final bool isJackpot = _isJackpotWithSeven() || _isJackpot();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  _icons[_selectedIndexes[0]],
                  width: 100,
                  height: 100,
                ),
                Image.asset(
                  _icons[_selectedIndexes[1]],
                  width: 100,
                  height: 100,
                ),
                Image.asset(
                  _icons[_selectedIndexes[2]],
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spin,
              child: const Text('Spin'),
            ),
            const SizedBox(height: 20),
            Text(
              _isJackpotWithSeven()
                  ? 'Jackpot with 7!'
                  : _isJackpot()
                      ? 'Jackpot!'
                      : 'You lost, try again!',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: isJackpot ? Colors.yellow : null,
    );
  }
}
