import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';
import 'package:study_assistant_ai/ui/intro_screen/intro_screen.dart';

import '../../ui/notes/page/notes_page.dart';
import '../../ui/notes/page/show_note.dart';

class RouteGenerator {
  static Route? generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    return PageRouteBuilder(
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SharedAxisTransition(
          animation: animation,
          fillColor: Colors.white,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      reverseTransitionDuration: const Duration(milliseconds: 125),
      transitionDuration: const Duration(milliseconds: 225),
      pageBuilder: (c, a1, a2) {
        return getPage(settings, args);
      },
      settings: settings,
    );
  }

  static Widget getPage(RouteSettings settings, args) {
    switch (settings.name) {
      case ChatPage.routeName:
        return const ChatPage();
      case NotesPage.routeName:
        return const NotesPage();
      case IntroScreen.routeName:
        return const IntroScreen();
      case ShowNote.routeName:
        return ShowNote();
      default:
        // settings = settings.copyWith(name: DefaultRoute.routeName);
        return const DefaultRoute();
    }
  }
}

class DefaultRoute extends StatelessWidget {
  static const routeName = '/DefaultRoute';

  const DefaultRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
