import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';

class CheckboxListTileRiverpod extends ConsumerWidget {
  CheckboxListTileRiverpod({Key? key}) : super(key: key);

  //家事の名前MOCK
  final List<String> kajinameMock = ['部屋掃除', '洗濯', '料理', '皿洗い'];

  final AutoDisposeStateProvider<List<bool>> _checkedListProvider =
      StateProvider.autoDispose<List<bool>>((ref) {
    return List.generate(4, (index) => false);
  });

  final ProviderListenable<dynamic> _changeNotifierProvider =
      ChangeNotifierProvider((ref) {
    return ChangeNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> checkedList = ref.watch(_checkedListProvider);
    final changeNotifier = ref.watch(_changeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("家事をえらんでね")),
      body: Column(
        children: [
          //家事リストビュー
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => CheckboxListTile(
                title: Text(kajinameMock[index]),
                value: checkedList[index],
                onChanged: (bool? checkedValue) {
                  ref.read(_checkedListProvider.notifier).state[index] =
                      checkedValue!;
                  changeNotifier.notifyListeners();
                },
              ),
              separatorBuilder: (context, index) {
                return const Divider(height: 0.5);
              },
              itemCount: kajinameMock.length,
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
