import 'package:hive_flutter/hive_flutter.dart';
part 'agenda_model.g.dart';

@HiveType(typeId: 1)
class AgendaModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String? note;
  @HiveField(3)
  bool isCompleted;

  AgendaModel({
    required this.title,
    required this.date,
    required this.isCompleted,
    this.note,
  });
}
