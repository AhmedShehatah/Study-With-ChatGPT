import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:study_assistant_ai/blocs/notes/cubit/notes_cubit.dart';
import 'package:study_assistant_ai/core/connectivity/network_connectivity.dart';
import 'package:study_assistant_ai/core/constansts/app_font.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';

import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/enums/interstitial_enum.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/vertical_padding.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_over_all.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_widget.dart';
import 'package:study_assistant_ai/ui/notes/page/show_note.dart';

import '../../../core/ads/ads_manager.dart';
import '../../../core/enums/screens_enum.dart';
import '../../../core/shared_prefs/shared_prefs.dart';
import '../../../models/note_model.dart';
import '../../common/widgets/empty_list_widget.dart';

// ignore: must_be_immutable
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);
  static const String routeName = "/notes-page";

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  InterstitialAd? interstitialAd;

  void loadAd() async {
    interstitialAd =
        await AdsManger.loadInterstitialAd(InterStitialEnum.notesAdd);
  }

  void showAd() {
    final prefs = DIManager.findDep<SharedPrefs>().notesClickCount;
    if (interstitialAd != null && prefs.val % 2 == 0 && prefs.val > 0) {
      interstitialAd!.show();
      prefs.val = 0;
    } else {
      prefs.val++;
    }
  }

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
  var _connection = false;
  @override
  void initState() {
    super.initState();
    loadAd();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      DIManager.findDep<NetworkConnectivity>().checkConnectivity(event);
      setState(() {
        _connection = (event != ConnectivityResult.none);
      });
    });
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.cardBorderRadius)),
        onPressed: () {
          showAd();
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
      drawer: const DrawerWidget(drawerTab: OverallDrawerTabs.notes),
      body: notes.isEmpty
          ? const EmptyListWidget(
              title: "No Notes Yet!",
            )
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
      bottomNavigationBar: DIManager.findDep<NetworkConnectivity>()
              .isConnected()
          ? SizedBox(
              height: ScreenHelper.fromHeight(8),
              child:
                  AdWidget(ad: AdsManger.loadBannerAd(ScreensEnum.notesScreen)))
          : null,
    );
  }
}
