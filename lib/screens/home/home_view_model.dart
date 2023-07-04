import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/remote/i_home_repository.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/models/photos.dart';
import 'package:zetaton_task/routes/routes_names.dart';
import 'package:zetaton_task/services/favorites_service.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  final IHomeRepository homeRepository;
  final IConnectionService connectionService;
  final IMessageService messageService;
  final IFirebaseService firebaseService;
  final FavoritesDataService favDataService;

  HomeViewModel({
    required this.homeRepository,
    required this.connectionService,
    required this.messageService,
    required this.firebaseService,
    required this.favDataService,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Photos> _photos = [];
  List<Photos> get photos => _photos;

  Future<void> initialGetAllPhotos() async {
    Future.wait([_getPhotos(), _getFavoriteWallpapers()]);
  }

  Future<void> _getPhotos() async {
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
    var photosResponse = await homeRepository.getPhotos(numberOfPhotos: 40);
    if (photosResponse.isError) {
      setLoadingState(false);
      messageService.showErrorSnackBar(
        '',
        photosResponse.asError!.error.toString(),
      );
      return;
    }
    _photos = photosResponse.asValue!.value.photos;
    setLoadingState(false);
    notifyListeners();
  }

  void navigateToDetailsScreenAction(Photos photo) {
    Get.toNamed(Routes.photoDetailsRoute, arguments: photo);
  }

  void navigateToFavoritesScreenAction() {
    Get.toNamed(Routes.favoritesRoute);
  }

  Future<void> _getFavoriteWallpapers() async {
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
    List<dynamic> _photos = [];
    var responseValue = favPhotosResponse.asValue!.value;
    for (int i = 0; i <= responseValue.docs.length - 1; i++) {
      _photos =
          responseValue.docs[i].data()[Constant.firebaseQueryParam.favorites];
    }
    favDataService.setPhotosData(_photos);
    notifyListeners();
  }

  Future<void> logoutAction() async {
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
    messageService.showDecisionAlertDialog(
      message: Constant.titles.sureLogout,
      confirm: Constant.titles.logout,
      cancel: Constant.titles.cancel,
      onConfirm: () async {
        await firebaseService.logoutAsync();
        Get.offAndToNamed(Routes.loginRoute);
      },
      onCancel: () => Get.back(),
    );
  }
}
