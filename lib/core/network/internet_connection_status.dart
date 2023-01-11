import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseInternetConnectionStatus {
  Future<bool> get isConnected;
}

class InternetConnectionStat implements BaseInternetConnectionStatus {
  final InternetConnectionChecker connectionChecker;

  InternetConnectionStat({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
