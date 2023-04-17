import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_header.dart';
import 'package:study_assistant_ai/ui/notes/page/notes_page.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../core/constansts/dimens.dart';
import 'package:koukicons_jw/phoneChat.dart';
import 'package:koukicons_jw/notebook2.dart';
import 'package:koukicons_jw/bookmarkC.dart';
import '../agenda/page/agenda_page.dart';
import 'drawer_over_all.dart';

class DrawerWidget extends StatelessWidget {
  final OverallDrawerTabs? drawerTab;

  final Null Function()? onCloseDrawer;
  final Null Function()? onOpenDrawer;
  final Function(int index)? moveToPage;

  const DrawerWidget({
    Key? key,
    required this.drawerTab,
    this.onCloseDrawer,
    this.onOpenDrawer,
    this.moveToPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
          right: Radius.circular(Dimens.cardBorderRadius)),
      child: Container(
        // width: 0.8.sw,
        height: 1.0.sh,
        color: Colors.black87,
        child: Column(
          children: [
            const DrawerHeaderWidget(),
            _buildDrawerPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerPage() {
    return SizedBox(
      width: ScreenHelper.width * 0.6,
      child: Column(
        children: [
          ListTile(
            leading: KoukiconsPhoneChat(
              height: Dimens.iconSize,
            ),
            title: const Text('Chat'),
            selected: drawerTab == OverallDrawerTabs.chat,
            onTap: () {
              if (drawerTab == OverallDrawerTabs.chat) return;
              DIManager.findNavigator()
                  .pushReplacementNamed(ChatPage.routeName);
            },
          ),
          ListTile(
            leading: KoukiconsNotebook2(height: Dimens.iconSize),
            title: const Text('Notes'),
            selected: drawerTab == OverallDrawerTabs.notes,
            onTap: () {
              if (drawerTab == OverallDrawerTabs.notes) return;
              DIManager.findNavigator()
                  .pushReplacementNamed(NotesPage.routeName);
            },
          ),
          ListTile(
            leading: KoukiconsBookmarkC(height: Dimens.iconSize),
            title: const Text('Agenda'),
            selected: drawerTab == OverallDrawerTabs.agenda,
            onTap: () {
              if (drawerTab == OverallDrawerTabs.agenda) return;
              DIManager.findNavigator()
                  .pushReplacementNamed(AgendaPage.routeName);
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
