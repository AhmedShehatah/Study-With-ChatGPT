import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:study_assistant_ai/core/ads/ads_manager.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/enums/interstitial_enum.dart';
import 'package:study_assistant_ai/core/shared_prefs/shared_prefs.dart';
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

class DrawerWidget extends StatefulWidget {
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
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  InterstitialAd? interstitialAd;
  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() async {
    interstitialAd =
        await AdsManger.loadInterstitialAd(InterStitialEnum.navigation);
  }

  void showAd() {
    Logger().d(DIManager.findDep<SharedPrefs>().navigationAd.val);
    if (interstitialAd != null &&
        DIManager.findDep<SharedPrefs>().navigationAd.val % 2 == 1) {
      interstitialAd!.show();
      DIManager.findDep<SharedPrefs>().navigationAd.val = 0;
    } else {
      DIManager.findDep<SharedPrefs>().navigationAd.val++;
    }
  }

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
            selected: widget.drawerTab == OverallDrawerTabs.chat,
            onTap: () {
              if (widget.drawerTab == OverallDrawerTabs.chat) return;
              showAd();
              DIManager.findNavigator()
                  .pushReplacementNamed(ChatPage.routeName);
            },
          ),
          ListTile(
            leading: KoukiconsNotebook2(height: Dimens.iconSize),
            title: const Text('Notes'),
            selected: widget.drawerTab == OverallDrawerTabs.notes,
            onTap: () {
              if (widget.drawerTab == OverallDrawerTabs.notes) return;
              showAd();
              DIManager.findNavigator()
                  .pushReplacementNamed(NotesPage.routeName);
            },
          ),
          ListTile(
            leading: KoukiconsBookmarkC(height: Dimens.iconSize),
            title: const Text('Agenda'),
            selected: widget.drawerTab == OverallDrawerTabs.agenda,
            onTap: () {
              if (widget.drawerTab == OverallDrawerTabs.agenda) return;
              showAd();
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
