import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/remote/i_search_repository.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';
import 'package:zetaton_task/models/photos.dart';
import 'package:zetaton_task/routes/routes_names.dart';

@injectable
class SearchViewModel extends ChangeNotifier {
  final IConnectionService connectionService;
  final IMessageService messageService;
  final IRequestService requestService;
  final ISearchRepository searchRepository;

  SearchViewModel({
    required this.requestService,
    required this.connectionService,
    required this.messageService,
    required this.searchRepository,
  });

  TextEditingController searchController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Photos> _photos = [];
  List<Photos> get photos => _photos;


  Future<void> onSearchAction()async{
    setLoadingState(true);
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
    if(searchController.text.isEmpty){
      setLoadingState(false);
      Fluttertoast.showToast(
        msg: 'Type a search keyword first',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0.spMin,
      );
      return;
    }
    var response = await searchRepository.getSearchedPhotos(
        numberOfPhotos: 1, searchParam: searchController.text);

    if(response.isError){
      setLoadingState(false);
      Fluttertoast.showToast(
        msg: response.asError!.error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.spMin,
      );
    }

    _photos = response.asValue!.value.photos;
    setLoadingState(false);
  }

  void navigateToDetailsScreenAction(Photos photo) {
    Get.toNamed(Routes.photoDetailsRoute, arguments: photo);
  }
}
