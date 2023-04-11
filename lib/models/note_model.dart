import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  DateTime creationDate;
  @HiveField(4)
  bool isImportant;

  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.creationDate,
    this.isImportant = false,
  });
}
