import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/enums/interstitial_enum.dart';
import 'package:study_assistant_ai/core/shared_prefs/shared_prefs.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';

import '../../core/ads/ads_manager.dart';
import '../../core/constansts/dimens.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const String routeName = "/intro-screen";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      bodyPadding: Dimens.cardInternalPadding,
      pages: _pages(),
      showNextButton: true,
      next: const Text("Next"),
      showSkipButton: false,
      done: const Text("Done"),
      onDone: () {
        DIManager.findDep<SharedPrefs>().firstTime.val = false;
        var pd = ProgressDialog(
          context,
          isDismissible: false,
        );
        pd.style(message: 'Please Wait Preparing App');
        pd.show();
        AdsManger.loadInterstitialAd(InterStitialEnum.navigation).then((ad) {
          pd.hide();
          if (ad != null) {
            ad.show();
          }
        });
        DIManager.findNavigator().offAll(ChatPage.routeName);
      },
    );
  }

  List<PageViewModel> _pages() {
    return [
      PageViewModel(
        title: "ChatGPT Assistant",
        body:
            "Meet your personal AI study assistant, ChatGPT, and get expert help with all your study needs.",
        image: Image.asset(
          'assets/images/chatbot.png',
          height: ScreenHelper.fromHeight(40),
        ),
        decoration: PageDecoration(
            bodyTextStyle: TextStyle(
          color: DIManager.findCC().primaryColor,
        )),
      ),
      PageViewModel(
        title: "Notes",
        body:
            "Never forget an idea or important information again with our Notes feature.",
        image: Image.asset(
          'assets/images/book.png',
          height: ScreenHelper.fromHeight(40),
        ),
        decoration: PageDecoration(
            bodyTextStyle: TextStyle(
          color: DIManager.findCC().primaryColor,
        )),
      ),
      PageViewModel(
        title: "Agenda",
        body:
            "Stay organized and on top of your schedule with our Agenda feature.",
        image: Image.asset(
          'assets/images/agenda.png',
          height: ScreenHelper.fromHeight(40),
        ),
        decoration: PageDecoration(
            bodyTextStyle: TextStyle(
          color: DIManager.findCC().primaryColor,
        )),
      ),
    ];
  }
}
