class ApplicationState {
  bool isHomeDrawerOpened;
  bool isSideDrawerShowed;
  Function? setHandleOfDrawer;
  bool isBottomBarShowed;

  ApplicationState({
    this.setHandleOfDrawer,
    required this.isSideDrawerShowed,
    required this.isHomeDrawerOpened,
    required this.isBottomBarShowed,
  });

  factory ApplicationState.initState() => ApplicationState(
        isHomeDrawerOpened: false,
        isBottomBarShowed: true,
        isSideDrawerShowed: false,
      );
  ApplicationState copyWith(
      {Function? setHandleOfDrawer,
      bool? isHomeDrawerOpened,
      bool? isSideDrawerShowed,
      bool? isBottomBarShowed}) {
    return ApplicationState(
      setHandleOfDrawer: setHandleOfDrawer ?? this.setHandleOfDrawer,
      isSideDrawerShowed: isSideDrawerShowed ?? this.isSideDrawerShowed,
      isHomeDrawerOpened: isHomeDrawerOpened ?? this.isHomeDrawerOpened,
      isBottomBarShowed: isBottomBarShowed ?? this.isBottomBarShowed,
    );
  }
}
