import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';

@Singleton(as: IConnectionService)
class ConnectionService implements IConnectionService{
  @override
  Future<bool> checkConnection() {
    return InternetConnectionChecker().hasConnection;
  }
}