import 'package:flutter/foundation.dart';

abstract class IConnectionService with ChangeNotifier{
  Future<bool> checkConnection();
}