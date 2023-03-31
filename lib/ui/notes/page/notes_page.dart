import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:study_assistant_ai/core/constansts/app_style.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_over_all.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_widget.dart';
import 'package:study_assistant_ai/ui/notes/page/show_note.dart';

// ignore: must_be_immutable
class NotesPage extends StatelessWidget {
  NotesPage({Key? key}) : super(key: key);
  static const String routeName = "/notes-page";
  List<NoteModel> notes = [
    NoteModel(id: 1, title: "hello", body: "bro", creationDate: DateTime.now()),
    NoteModel(
        id: 1,
        title: "hello",
        body:
            "bro faskljfdas fdskajf aklj f aklsdfjkl dsfjakljf kdlajlkdfj kljfdaslk jfd;akljdfs lkj ldaskjlkjadsflkfdsjlkjdsfl;k jlasdfjkl adsfjlkjdsf lkjdsf adsfkljdsf lkjfdskl;a jkldasfj lk;adsfjlkdsfj ;lkj",
        creationDate: DateTime.now()),
    NoteModel(id: 1, title: "hello", body: "bro", creationDate: DateTime.now()),
    NoteModel(id: 1, title: "hello", body: "bro", creationDate: DateTime.now()),
    NoteModel(id: 1, title: "hello", body: "bro", creationDate: DateTime.now()),
  ];
  final lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        shape: AppStyle.appBarStyle,
      ),
      drawer: const DrawerWidget(drawerTab: OverallDrawerTabs.flashcards),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.fromWidth(2),
          vertical: ScreenHelper.fromHeight(2),
        ),
        child: MasonryGridView.count(
          itemCount: notes.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            var formattedDate =
                DateFormat.yMMMd().format(notes[index].creationDate);
            Random random = Random();
            Color bg = lightColors[random.nextInt(8)];
            return GestureDetector(
              onTap: () {
                DIManager.findNavigator()
                    .pushNamed(ShowNote.routeName, arguments: {
                  "notesData": notes[index],
                  "index": index,
                });
              },
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        top: 5,
                        right: 8,
                        left: 8,
                        bottom: 0,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Text(
                          notes[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        notes[index].body,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NoteModel {
  int id;
  String title;
  String body;
  DateTime creationDate;

  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.creationDate});
}
