import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:study_assistant_ai/blocs/notes/cubit/notes_cubit.dart';
import 'package:study_assistant_ai/core/constansts/app_font.dart';
import 'package:study_assistant_ai/core/constansts/app_style.dart';

import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/vertical_padding.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_over_all.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_widget.dart';
import 'package:study_assistant_ai/ui/notes/page/show_note.dart';

import '../../../models/note_model.dart';

// ignore: must_be_immutable
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);
  static const String routeName = "/notes-page";

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  List<NoteModel> notes = [];

  final lightColors = [
    Colors.blueGrey.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.blue.shade200,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  late TabController _tabs;
  @override
  void initState() {
    super.initState();

    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.index == 0) {
      notes = DIManager.findDep<NotesCubit>().getAllNotes();
    } else {
      notes = DIManager.findDep<NotesCubit>().getImportantNotes();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DIManager.findNavigator().pushNamed(ShowNote.routeName, arguments: {
            "notesData": NoteModel(
                body: '', id: 0, title: '', creationDate: DateTime.now()),
            "index": null,
            "new": true
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text("Notes"),
        bottom: TabBar(
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Important'),
          ],
          controller: _tabs,
          indicatorColor: Colors.lightGreen,
          onTap: (idx) {
            setState(() {});
          },
        ),
      ),
      drawer: const DrawerWidget(drawerTab: OverallDrawerTabs.flashcards),
      body: notes.isEmpty
          ? _noNotesYet()
          : Container(
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
                  index = notes.length - index - 1;
                  var formattedDate =
                      DateFormat.yMMMd().format(notes[index].creationDate);
                  Random random = Random();
                  Color bg = lightColors[random.nextInt(8)];
                  return InkWell(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text(
                                  "Do you want to delete this note?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      notes[index].delete();
                                      DIManager.findNavigator().pop();
                                    });
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    DIManager.findNavigator().pop();
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          });
                    },
                    onTap: () {
                      DIManager.findNavigator().pushNamed(ShowNote.routeName,
                          arguments: {
                            "notesData": notes[index],
                            "index": index,
                            "new": false
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    notes[index].isImportant =
                                        !notes[index].isImportant;
                                    notes[index].save();
                                  });
                                },
                                icon: notes[index].isImportant
                                    ? const Icon(Icons.star,
                                        color: Colors.yellow)
                                    : const Icon(Icons.star_outline),
                              ),
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

  Widget _noNotesYet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/note.png',
            // height: 200.h,
          ),
          const VerticalPadding(3),
          Text(
            "No Notes Yet!",
            style: TextStyle(fontSize: AppFontSize.fontSize_18),
          )
        ],
      ),
    );
  }
}
