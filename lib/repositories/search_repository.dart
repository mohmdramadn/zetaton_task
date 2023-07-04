import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/remote/i_search_repository.dart';
import 'package:async/async.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';
import 'package:zetaton_task/models/page.dart';

@Injectable(as: ISearchRepository)
class SearchRepository implements ISearchRepository{
  final IRequestService requestService;

  SearchRepository({required this.requestService});

  @override
  Future<Result<Page>> getSearchedPhotos(
      {required int numberOfPhotos, required String searchParam}) async {
    final response = await requestService
        .getRequest('${Constant.urls.searchApi}$searchParam');
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