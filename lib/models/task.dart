import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class Task {
  Task({
    required this.title,
    this.isDone = false,
    required String id,
    // idはnullならuuidが自動採番される
  }) : id = id ?? _uuid.v4();

  final String id;
  final String title;
  final bool isDone;
}
