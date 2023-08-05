import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ElevatedCardExample extends ConsumerWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("今日も頑張ろう！")),
      body: Column(
        children: [
          Row(
            children: const [
              SizedBox(width: 24),
              Text('ゆうだい'),
              SizedBox(width: 16),
              Icon(Icons.workspace_premium),
              Text('家事ブロンズ1'),
            ],
          ),
          const SizedBox(height: 32),
          Card(
            child: SizedBox(
              width: 364,
              height: 112,
              child: Center(
                child: Text(style: const TextStyle(fontSize: 36), '残り 3 つ'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
