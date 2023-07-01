import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';

class ConnectionService extends ChangeNotifier implements IConnectionService{
  @override
  Future<bool> checkConnection() {
    return InternetConnectionChecker().hasConnection;
  }
}