// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_assistant_ai/blocs/notes/cubit/notes_cubit.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';

import 'package:study_assistant_ai/core/utils/screen_utils/device_utils.dart';
import 'package:study_assistant_ai/core/utils/ui_utils/custom_snack_bar.dart';
import 'package:study_assistant_ai/models/note_model.dart';
import 'package:study_assistant_ai/ui/notes/page/notes_page.dart';

import '../../../core/validators/base_validator.dart';
import '../../../core/validators/required_validator.dart';

class ShowNote extends StatelessWidget {
  static const String routeName = "/show-note";
  final _formKey = GlobalKey<FormState>();
  ShowNote({
    super.key,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var note = args["notesData"] as NoteModel;
    titleController.text = note.title;
    bodyController.text = note.body;
    var formattedDate = DateFormat.yMMMd().format(note.creationDate);
    var time = DateFormat.jm().format(note.creationDate);
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
                        DIManager.findNavigator().pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                    ),
                    if (!args['new'])
                      IconButton(
                        color: Theme.of(context).colorScheme.background,
                        onPressed: () {
                          showDeleteDialog(context, note);
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("$formattedDate at $time"),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: titleController,
                            maxLines: null,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Title",
                            ),
                            style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500,
                            ),
                            validator: (value) => BaseValidator.validateValue(
                                context, value, [RequiredValidator()], true),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: bodyController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Type something...",
                            ),
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                            validator: (value) => BaseValidator.validateValue(
                                context, value, [RequiredValidator()], true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (titleController.text != note.title ||
                bodyController.text != note.body) {
              if (_formKey.currentState!.validate()) {
                note.title = titleController.text;
                note.body = bodyController.text;
                if (!args['new']) {
                  note.save();
                } else {
                  DIManager.findDep<NotesCubit>().saveNote(note);
                }
                DIManager.findNavigator().offAll(NotesPage.routeName);
              } else {
                CustomSnackbar.showSnackbar("Note must have title and body");
              }
            } else {
              showSameContentDialog(context);
            }
          },
          label: const Text("Save"),
          icon: const Icon(
            Icons.save,
          ),
        ));
  }
}

void showDeleteDialog(BuildContext context, NoteModel noteData) {
  // final AuthController authController = Get.find<AuthController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
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
              noteData.delete();
              DIManager.findNavigator().offAll(NotesPage.routeName);
            },
          ),
          TextButton(
            child: Text(
              "No",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onPressed: () {
              DIManager.findNavigator().pop();
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
        shape: const RoundedRectangleBorder(
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
