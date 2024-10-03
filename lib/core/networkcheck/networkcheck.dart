
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var _isConnected = true.obs;
  var connectivityResult;

  NetworkService() {
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      _isConnected.value = connectivityResult != ConnectivityResult.none;
    });
  }

  bool get isConnected => _isConnected.value;

  Future<bool> checkNetwork() async {
     connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  Future<bool> hasInternetConnection() async {
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Make a simple HTTP GET request to check internet access
        final response = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
        if (response.statusCode == 200) {
          return true;
        }
      } catch (e) {
        // Error occurred (e.g., no internet, request timed out)
        return false;
      }
    }
    return false;
  }

}