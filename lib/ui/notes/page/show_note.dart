import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_assistant_ai/core/constansts/dimens.dart';
import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';

class ShowNote extends StatelessWidget {
  static const String routeName = "/show-note";

  ShowNote({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    titleController.text = args["notesData"].title;
    bodyController.text = args["notesData"].body;
    var formattedDate =
        DateFormat.yMMMd().format(args["notesData"].creationDate);
    var time = DateFormat.jm().format(args["notesData"].creationDate);
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenHelper.fromWidth(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      color: Theme.of(context).colorScheme.background,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.background,
                      onPressed: () {
                        showDeleteDialog(context, args["notesData"]);
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("$formattedDate at $time"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: titleController,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: "Title",
                          ),
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: bodyController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: "Type something...",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (titleController.text != args["notesData"].title ||
                bodyController.text != args["notesData"].body) {
              // Database().updateNote(authController.user.uid,
              //     titleController.text, bodyController.text, noteData.id);
              // Get.back();
              // titleController.clear();
              // bodyController.clear();
            } else {
              showSameContentDialog(context);
            }
          },
          label: Text("Save"),
          icon: Icon(Icons.save),
        ));
  }
}

void showDeleteDialog(BuildContext context, noteData) {
  // final AuthController authController = Get.find<AuthController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "Delete Note?",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text("Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.titleMedium),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Yes",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () {
              // Get.back();
              // Database().delete(authController.user.uid, noteData.id);
              // Get.back(closeOverlays: true);
            },
          ),
          TextButton(
            child: Text(
              "No",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showSameContentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "No change in content!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text("There is no change in content.",
            style: Theme.of(context).textTheme.titleMedium),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Okay",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
