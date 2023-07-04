import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@singleton
class FavoritesDataService extends ChangeNotifier{
  List<dynamic>? _photos;
  List<dynamic>? get photos => _photos;

  void setPhotosData(value){
    _photos = value;
    notifyListeners();
  }
}