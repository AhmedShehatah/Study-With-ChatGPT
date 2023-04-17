import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:study_assistant_ai/blocs/agenda/agenda_cubit.dart';
import 'package:study_assistant_ai/core/constansts/app_font.dart';
import 'package:study_assistant_ai/core/constansts/app_style.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/horizontal_padding.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/util_functions.dart';
import 'package:study_assistant_ai/models/agenda_model.dart';

import '../../../blocs/agenda/agenda_state.dart';
import '../../common/widgets/empty_list_widget.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      bloc: DIManager.findDep<AgendaCubit>(),
      builder: (context, state) {
        if (DIManager.findDep<AgendaCubit>().getAllEvents().isEmpty) {
          return const EmptyListWidget(
            title: 'No Events Yet',
          );
        }
        return GroupedListView<AgendaModel, DateTime>(
          elements: DIManager.findDep<AgendaCubit>().getAllEvents(),
          order: GroupedListOrder.DESC,
          groupBy: (event) => DateTime(
            event.date.year,
            event.date.month,
            event.date.day,
          ),
          groupHeaderBuilder: (event) => Container(
            padding: Dimens.textPadding,
            child: Row(
              children: [
                Text(
                  DateFormat('EEEE').format(event.date),
                  style: AppStyle.text14Style.copyWith(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                const HorizontalPadding(3),
                Text(DateFormat('MMM d, y').format(event.date)),
              ],
            ),
          ),
          separator: const Divider(),
          itemBuilder: (ctx, event) {
            return SizedBox(
              height: null,
              child: ListTile(
                onTap: () {
                  UtilFunctions.agendaModalSheet(context, shownEvent: event);
                },
                title: Text(
                  event.title.capitalizeFirst!,
                  style: TextStyle(
                    decoration:
                        event.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: event.isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.blue,
                      )
                    : null,
                subtitle: Row(children: [
                  Icon(
                    Icons.event,
                    size: Dimens.smallIconsSizee,
                    color: Colors.grey,
                  ),
                  const HorizontalPadding(2),
                  Text(
                    DateFormat('MMM d, y').format(event.date),
                    style: TextStyle(fontSize: AppFontSize.fontSize_10),
                  ),
                ]),
                trailing: IconButton(
                  onPressed: () {
                    _showModalSheet(event);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showModalSheet(AgendaModel event) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.bottomSheetBorderRadius),
            topRight: Radius.circular(Dimens.bottomSheetBorderRadius),
          ),
        ),
        builder: (ctx) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title:
                        Text(event.isCompleted ? "Not Completed" : "Completed"),
                    leading: Icon(
                      event.isCompleted ? Icons.timer : Icons.check,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      event.isCompleted = !event.isCompleted;
                      event.save();
                      DIManager.findDep<AgendaCubit>().refresh();
                      DIManager.findNavigator().pop();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Edit"),
                    leading: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      UtilFunctions.agendaModalSheet(context,
                          shownEvent: event);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Delete"),
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      event.delete();
                      DIManager.findDep<AgendaCubit>().refresh();
                      DIManager.findNavigator().pop();
                    },
                  ),
                ],
              );
            }),
          );
        });
  }
}
