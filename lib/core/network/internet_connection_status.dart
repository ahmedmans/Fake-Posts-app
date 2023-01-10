import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseInternetConnectionStatus {
  Future<bool> get intrenetConnected;
}

class InternetConnectionStat implements BaseInternetConnectionStatus {
  final InternetConnectionChecker internetConnectionChecker;

  InternetConnectionStat({required this.internetConnectionChecker});

  @override
  Future<bool> get intrenetConnected => internetConnectionChecker.hasConnection;
}
