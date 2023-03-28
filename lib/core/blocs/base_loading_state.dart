import 'package:study_assistant_ai/core/blocs/base_state.dart';

class BaseLoadingState extends BaseState {
  final String? message;
  BaseLoadingState({this.message});
}
