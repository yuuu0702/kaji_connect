import 'package:flutter/material.dart';

class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Card(
            child: SizedBox(
              width: 364,
              height: 112,
              child: Center(child: Text('Elevated Card')),
            ),
          ),
        ],
      ),
    );
  }
}
