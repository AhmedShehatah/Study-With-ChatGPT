import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_assistant_ai/ui/chat/page/chat_page.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_header.dart';
import 'package:study_assistant_ai/ui/notes/page/notes_page.dart';
import '../../../../core/di/di_manager.dart';
import '../../blocs/application/application_cubit.dart';
import '../../blocs/application/application_state.dart';
import '../../blocs/chat/cubit/chat_cubit.dart';
import '../../core/constansts/app_consts.dart';
import '../../core/constansts/dimens.dart';
import '../../core/constansts/duration_consts.dart';
import 'drawer_widget.dart';

class DrawerOverAllWidget extends StatefulWidget {
  final Widget? child;

  const DrawerOverAllWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerOverAllWidgetState createState() => _DrawerOverAllWidgetState();
}

class _DrawerOverAllWidgetState extends State<DrawerOverAllWidget> {
  var _drawerToOpen = OverallDrawerTabs.chat;
  double height = 0.12.sh;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    // WidgetsBinding.instance!.handlePopRoute();
    DIManager.findDep<ApplicationCubit>().onOverallDrawerChanged(
      _openDrawer,
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool closeDrawerOverAllIfItOpens() {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.openEndDrawer();
      return true;
    }
    return false;
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return closeDrawerOverAllIfItOpens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: DrawerWidget(
        drawerTab: _drawerToOpen,
        onCloseDrawer: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        onOpenDrawer: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: Stack(
        children: [
          Container(child: widget.child),
        ],
      ),
    );
  }

  void _openDrawer(OverallDrawerTabs tab) {
    _scaffoldKey.currentState!.openDrawer();
    setState(() {
      _drawerToOpen = tab;
    });

    // if(!_scaffoldKey.currentState.isDrawerOpen)
  }
}

enum OverallDrawerTabs {
  chat,
  flashcards,
}
