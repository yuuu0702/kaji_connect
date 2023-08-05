import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';

@immutable
class Todo {
  const Todo(
      {required this.id, required this.description, required this.completed});

  // イミュータブルなクラスのプロパティはすべて `final` にする必要があります。
  final String id;
  final String description;
  final bool completed;

  // Todo はイミュータブルであり、内容を直接変更できないためコピーを作る必要があります。
  // これはオブジェクトの各プロパティの内容をコピーして新たな Todo を返すメソッドです。
  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

// StateNotifierProvider に渡すことになる StateNotifier クラスです。
// このクラスではステートを `state` プロパティの外に公開しません。
// つまり、ステートに関しては public なゲッターやプロパティは作らないということです。
// public メソッドを通じて UI 側にステートの操作を許可します。
class TodosNotifier extends StateNotifier<List<Todo>> {
  // Todo リストを空のリストとして初期化します。
  TodosNotifier()
      : super([
          Todo(description: '部屋掃除', id: '1', completed: false),
          Todo(description: '洗濯', id: '2', completed: false),
          Todo(description: '料理', id: '3', completed: false),
        ]);

  // Todo の追加
  void addTodo(Todo todo) {
    // ステート自体もイミュータブルなため、`state.add(todo)`
    // のような操作はできません。
    // 代わりに、既存 Todo と新規 Todo を含む新しいリストを作成します。
    // Dart のスプレッド演算子を使うと便利ですよ!
    state = [...state, todo];
    // `notifyListeners` などのメソッドを呼ぶ必要はありません。
    // `state =` により必要なときに UI側 に通知が届き、ウィジェットが更新されます。
  }

  // Todo の削除
  void removeTodo(String todoId) {
    // しつこいですが、ステートはイミュータブルです。
    // そのため既存リストを変更するのではなく、新しくリストを作成する必要があります。
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Todo の完了ステータスの変更
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // ID がマッチした Todo のみ、完了ステータスを変更します。
        if (todo.id == todoId)
          // またまたしつこいですが、ステートはイミュータブルなので
          // Todo クラスに実装した `copyWith` メソッドを使用して
          // Todo オブジェクトのコピーを作る必要があります。
          todo.copyWith(completed: !todo.completed)
        else
          // ID が一致しない Todo は変更しません。
          todo,
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

class CheckboxListTileRiverpod extends ConsumerWidget {
  CheckboxListTileRiverpod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("家事をえらんでね")),
      body: Column(
        children: [
          //家事リストビュー
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  value: todo.completed,
                  onChanged: (value) =>
                      ref.read(todosProvider.notifier).toggle(todo.id),
                  title: Text(todo.description),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 0.5),
              itemCount: todos.length,
            ),
          ),
          FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ElevatedCardExample()));
              },
              child: const Text('次へ'))
        ],
      ),
    );
  }
}
