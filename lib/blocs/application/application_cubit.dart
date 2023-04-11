import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_assistant_ai/core/db/hive_manager.dart';
import 'package:study_assistant_ai/core/di/di_manager.dart';
import '../../core/errors/app_error_handler.dart';
import 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.initState());

  Future<void> init() async {
    onAppInit();
  }

  void onAppInit() {
    /// init error catcher
    AppErrorHandler.init();
    DIManager.findDep<IHiveManger>().initHive();
  }

  refreshColor() {
    emit(state.copyWith());
  }

  void onHomeDrawer(bool isOpened) {
    emit(state.copyWith(isHomeDrawerOpened: isOpened));
  }

  Future isBottomBarShowed(bool isOpened) async {
    emit(state.copyWith(isBottomBarShowed: isOpened));
    return null;
  }

  void setSideDrawer(bool isShowed) {
    //  if(state.isSideDrawerShowed != isShowed)
    emit(state.copyWith(isSideDrawerShowed: isShowed));
  }

  Future onOverallDrawerChanged(Function setHandleOfDrawer) async {
    emit(
      state.copyWith(setHandleOfDrawer: setHandleOfDrawer),
    );
    return null;
  }

  Function? getOverallDrawerHandler() {
    return state.setHandleOfDrawer;
  }

  @override
  void emit(ApplicationState state) {
    super.emit(state);
  }
}
