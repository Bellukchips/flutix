part of 'services.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionController.add(_getStatusResult(result));
    });
  }
  ConnectivityStatus _getStatusResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
