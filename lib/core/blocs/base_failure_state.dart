import 'dart:ui';

import 'package:study_assistant_ai/core/blocs/base_state.dart';

import '../errors/base_error.dart';

class BaseFailureState extends BaseState {
  final BaseError? error;
  final VoidCallback? callback;

  const BaseFailureState(this.error, {this.callback});
}
