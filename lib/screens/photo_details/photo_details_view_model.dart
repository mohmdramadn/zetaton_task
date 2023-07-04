import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';
import 'package:zetaton_task/models/photos.dart';

@injectable
class PhotoDetailsViewModel extends ChangeNotifier {
  final IConnectionService connectionService;
  final IMessageService messageService;
  final IFirebaseService firebaseService;
  final IRequestService requestService;
  final Photos photo;

  PhotoDetailsViewModel({
    required this.connectionService,
    required this.messageService,
    required this.firebaseService,
    required this.requestService,
    required this.photo,
  });

  bool _isAddedToFav = false;
  bool get isAddedToFav => _isAddedToFav;
  void setAddedToFavState(value) {
    _isAddedToFav = value;
    notifyListeners();
  }

  List<String> _photos = [];

  Future<void> onFavoriteSelectedActionAsync() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
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
    _photos.add(photo.src!.large!);

    var favResponse =
        await firebaseService.updateFavoritesAsync(photos: _photos);
    if (favResponse.isError) {
      messageService.showErrorSnackBar(
        '',
        favResponse.asError!.error.toString(),
      );
      return;
    }
    setAddedToFavState(true);
    notifyListeners();
  }

  Future<void> onDownloadImageSelectedAction(String url) async {
    Fluttertoast.showToast(
      msg: Constant.titles.fetchingImageSrc,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0.spMin,
    );
    GallerySaver.saveImage(url).then((bool? success) {
      Fluttertoast.showToast(
        msg: Constant.titles.savedToGallery,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }, onError: (error) {
      Fluttertoast.showToast(
        msg: Constant.titles.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.spMin,
      );
    });
  }
}
