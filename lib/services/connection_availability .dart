import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionAvailibility {
  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
