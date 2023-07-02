import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/remote/i_home_repository.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/models/photos.dart';

@injectable
class HomeViewModel extends ChangeNotifier{
  final IHomeRepository homeRepository;
  final IConnectionService connectionService;
  final IMessageService messageService;

  HomeViewModel({
    required this.homeRepository,
    required this.connectionService,
    required this.messageService,
  });

  Future<void> getPhotos()async{
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
    var photosResponse = await homeRepository.getPhotos(numberOfPhotos: 10);
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

  List<Photos> _photos = [];
  List<Photos> get photos => _photos;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

}