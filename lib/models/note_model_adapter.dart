import 'package:hive/hive.dart';
import 'note_model.dart';

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.readInt(),
      title: reader.readString(),
      body: reader.readString(),
      creationDate: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      isImportant: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.body);
    writer.writeInt(obj.creationDate.millisecondsSinceEpoch);
    writer.writeBool(obj.isImportant);
  }
}
