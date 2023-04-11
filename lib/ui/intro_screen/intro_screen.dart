import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/shared_prefs/shared_prefs.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  static const String routeName = "/intro-screen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: _pages(),
        showNextButton: false,
        skip: const Text("Skip"),
        showSkipButton: true,
        done: const Text("Done"),
        onDone: () {
          DIManager.findDep<SharedPrefs>().firstTime.val = false;
          DIManager.findNavigator().offAll(ChatPage.routeName);
        },
      ),
    );
  }

  List<PageViewModel> _pages() {
    return [
      PageViewModel(
        title: "Chat with your AI Assistant !",
        body: "Strong AI bot uses chatGPT gpt-3.5-turbo model !",
        image: Image.asset(
          'assets/images/chat_intro.gif',
          height: ScreenHelper.fromHeight(40),
        ),
        decoration: PageDecoration(
            bodyTextStyle: TextStyle(
          color: DIManager.findCC().primaryColor,
        )),
      ),
      PageViewModel(
        title: "Notes",
        body: "You can easily save AI answers on your notes",
        image: Image.asset(
          'assets/images/notes_intro.gif',
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
