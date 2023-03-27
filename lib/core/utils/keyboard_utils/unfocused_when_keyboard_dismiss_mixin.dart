import 'dart:async';

import 'package:flutter/material.dart';

import 'keyboard_visibilty/my_keyboard_visibilty.dart';

mixin UnFocusWhenKeyboardDismissedMixin<T extends StatefulWidget> on State<T> {
  List<FocusNode> focusNodesListToUnFocus();

  // Keyboard detection
  final Stream<bool?> _keyboardVisibility = KeyboardVisibility.onChange;
  late StreamSubscription<bool?> _keyboardVisibilitySubscription;

  @override
  void initState() {
    _keyboardVisibilitySubscription =
        _keyboardVisibility.listen((bool? isVisible) {
      if (!isVisible!) {
        focusNodesListToUnFocus().forEach((element) {
          element.unfocus();
        });
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _keyboardVisibilitySubscription.cancel();
    super.dispose();
  }
}
