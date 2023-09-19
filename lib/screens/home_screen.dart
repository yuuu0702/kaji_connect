import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'kaji_select_screen.dart';

class ElevatedCardExample extends ConsumerWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);
    print(todos);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white, // ラベルの背景色
                    borderRadius: BorderRadius.circular(20), // 角丸の半径を指定
                  ),
                  child: const Text(
                    '今日の課題',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  width: 364,
                  height: 112,
                  decoration: BoxDecoration(
                    color: const Color(0xFF467FFF), // ラベルの背景色
                    borderRadius: BorderRadius.circular(20), // 角丸の半径を指定
                  ),
                  child: Center(
                    child: Text(
                      style: const TextStyle(fontSize: 36),
                      '残り${todos.toList()}つ',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
