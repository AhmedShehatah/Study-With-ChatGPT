import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  var _status = false;
  void checkConnectivity(ConnectivityResult event) {
    _status = (event != ConnectivityResult.none);
  }

  bool isConnected() {
    return _status;
  }
}
