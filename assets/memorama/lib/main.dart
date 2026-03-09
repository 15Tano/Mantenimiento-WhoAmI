import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MemoramaApp());
}

class MemoramaApp extends StatelessWidget {
  const MemoramaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorama Básico',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MemoramaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MemoramaPage extends StatefulWidget {
  const MemoramaPage({super.key});

  @override
  State<MemoramaPage> createState() => _MemoramaPageState();
}

class _MemoramaPageState extends State<MemoramaPage> {
  List<int> cards = [];
  List<bool> revealed = [];
  int? firstIndex;
  bool waiting = false;

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  void _generateCards() {
    List<int> baseNumbers = List.generate(8, (index) => index); // 8 pares
    cards = [...baseNumbers, ...baseNumbers];
    cards.shuffle(Random());
    revealed = List.generate(cards.length, (index) => false);
  }

  void _onCardTap(int index) async {
    if (waiting || revealed[index]) return;

    setState(() {
      revealed[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      if (cards[firstIndex!] != cards[index]) {
        waiting = true;
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          revealed[firstIndex!] = false;
          revealed[index] = false;
        });
      }
      firstIndex = null;
      waiting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memorama Básico')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onCardTap(index),
              child: Container(
                decoration: BoxDecoration(
                  color: revealed[index] ? Colors.blue[300] : Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: revealed[index]
                      ? Text(
                          '${cards[index]}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(''),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _generateCards();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
