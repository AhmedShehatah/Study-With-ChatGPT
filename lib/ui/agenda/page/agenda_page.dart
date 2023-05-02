import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:study_assistant_ai/blocs/agenda/agenda_cubit.dart';
import 'package:study_assistant_ai/core/constansts/app_style.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/keyboard_utils/unfocused_when_keyboard_dismiss_mixin.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/custom_snack_bar.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/util_functions.dart';
import 'package:study_assistant_ai/models/agenda_model.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_over_all.dart';
import 'package:study_assistant_ai/ui/drawer/drawer_widget.dart';
import 'package:intl/intl.dart';
import '../../../core/ads/ads_manager.dart';
import '../../../core/connectivity/network_connectivity.dart';
import '../../../core/constansts/dimens.dart';
import '../../../core/enums/screens_enum.dart';
import '../../../core/validators/base_validator.dart';
import '../../../core/validators/required_validator.dart';
import '../widget/events_list.dart';

class AgendaPage extends StatefulWidget {
  static const String routeName = "/agenda-page";
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(drawerTab: OverallDrawerTabs.agenda),
      appBar: AppBar(
        title: const Text('Agenda'),
        shape: AppStyle.appBarStyle,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UtilFunctions.agendaModalSheet(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.cardBorderRadius)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: const EventsList(),
      bottomNavigationBar:
          DIManager.findDep<NetworkConnectivity>().isConnected()
              ? SizedBox(
                  height: ScreenHelper.fromHeight(8),
                  child: AdWidget(
                      ad: AdsManger.loadBannerAd(ScreensEnum.agendaScreen)))
              : null,
    );
  }
}
