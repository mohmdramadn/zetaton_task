import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/remote/i_home_repository.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';
import 'package:async/async.dart';
import 'package:zetaton_task/models/page.dart';

@Injectable(as: IHomeRepository)
class HomeRepository implements IHomeRepository{
  final IRequestService requestService;

  HomeRepository({required this.requestService});

  @override
  Future<Result<Page>> getPhotos({required int numberOfPhotos}) async{
    final response = await requestService
        .getRequest('${Constant.urls.photosApi}$numberOfPhotos');
    try {
      response;
      return Result.value(Page.fromJson(response.data));
    } catch (error, stacktrace) {
      throw DioException(
        error: error,
        stackTrace: stacktrace,
        requestOptions: response.requestOptions,
      );
    }
  }
}