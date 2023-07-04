import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/services/favorites_service.dart';

@injectable
class FavoritesViewModel extends ChangeNotifier {
  final FavoritesDataService favDataService;
  final IFirebaseService firebaseService;
  final IConnectionService connectionService;

  FavoritesViewModel({
    required this.favDataService,
    required this.firebaseService,
    required this.connectionService,
  }) {
    _photos = favDataService.photos!;
  }

  List<dynamic> _photos = [];
  List<dynamic> get photos => _photos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getFavoriteWallpapers() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      setLoadingState(false);
      Fluttertoast.showToast(
        msg: Constant.titles.notConnected,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0.spMin,
      );
      return;
    }
    var favPhotosResponse = await firebaseService.getFavoritePhotos();
    if (favPhotosResponse.isError) return;
    List<dynamic> photos = [];
    var responseValue = favPhotosResponse.asValue!.value;
    for (int i = 0; i <= responseValue.docs.length - 1; i++) {
      photos =
          responseValue.docs[i].data()[Constant.firebaseQueryParam.favorites];
    }
    if (_photos.length != photos.length) {
      favDataService.setPhotosData(photos);
      _photos = _photos;
    }
    notifyListeners();
  }
}
