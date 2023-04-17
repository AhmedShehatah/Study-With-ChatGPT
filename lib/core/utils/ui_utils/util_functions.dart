import 'package:flutter/material.dart';

import '../../../blocs/agenda/agenda_cubit.dart';
import '../../../models/agenda_model.dart';
import '../../constansts/app_style.dart';
import '../../constansts/dimens.dart';
import '../../di/di_manager.dart';
import '../../validators/base_validator.dart';
import '../../validators/required_validator.dart';
import '../screen_utils/device_utils.dart';
import 'custom_snack_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class UtilFunctions {
  static Future<DateTime?> pickDate(BuildContext context) async {
    var now = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month - 1, 1),
      lastDate: DateTime(now.year, now.month + 2, 0),
    );
  }

  static void agendaModalSheet(BuildContext context,
      {AgendaModel? shownEvent}) {
    var formKey = GlobalKey<FormState>();
    var completed = false;
    var titleController = TextEditingController();
    var noteController = TextEditingController();
    var date = '';
    var event =
        AgendaModel(title: '', date: DateTime.now(), isCompleted: false);
    if (shownEvent != null) {
      completed = shownEvent.isCompleted;
      titleController.text = shownEvent.title;
      noteController.text = shownEvent.note ?? '';
      date = date = DateFormat('MMM d, y').format(shownEvent.date);
      event = shownEvent;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.bottomSheetBorderRadius),
          topRight: Radius.circular(Dimens.bottomSheetBorderRadius),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            height: ScreenHelper.height * 0.9,
            padding: Dimens.cardInternalPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => DIManager.findNavigator().pop(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (date.isEmpty) {
                            CustomSnackbar.showSnackbar('Choose date');
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            event.title = titleController.text.trim();
                            event.note = noteController.text.trim();
                            if (shownEvent != null) {
                              event.save();
                              DIManager.findDep<AgendaCubit>().refresh();
                            } else {
                              DIManager.findDep<AgendaCubit>()
                                  .saveToAgenda(event);
                            }
                            DIManager.findNavigator().pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.bigBorderRadius),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Transform.scale(
                          scale:
                              1.5, // change this value to adjust the size of the checkbox
                          child: Checkbox(
                            value: completed,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimens.bigBorderRadius)),
                            onChanged: (newValue) {
                              setState(() {
                                completed = newValue!;
                                event.isCompleted = completed;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: ScreenHelper.fromWidth(70),
                          child: TextFormField(
                            controller: titleController,
                            maxLines: 3,
                            minLines: 1,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Add a title",
                            ),
                            style: AppStyle.bigTitleStyle,
                            validator: (value) => BaseValidator.validateValue(
                                context, value, [RequiredValidator()], true),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () async {
                      var pickedDate = await UtilFunctions.pickDate(context);
                      if (pickedDate != null) {
                        setState(() {
                          date = DateFormat('MMM d, y').format(pickedDate);
                          event.date = pickedDate;
                        });
                      }
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                      ),
                      title: Text(
                        date.isEmpty ? 'Add date' : date,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  // const Divider(),
                  // const ListTile(
                  //   leading: Icon(
                  //     Icons.book,
                  //     color: Colors.grey,
                  //   ),
                  //   title: Text(
                  //     'Add subject',
                  //     style: TextStyle(color: Colors.grey),
                  //   ),
                  // ),
                  const Divider(),
                  Container(
                    padding: Dimens.cardInternalPadding,
                    child: TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Add a note",
                      ),
                      style: AppStyle.bigTitleStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
