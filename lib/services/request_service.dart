import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';

@Singleton(as: IRequestService)
class RequestService implements IRequestService {
  final dio = Dio();
  final _options = Options(
    headers: {'Authorization':Constant.pexels.key}
  );
  final prettyDioLogger = PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

  @override
  Future<Response> getRequest(String url) {
    dio.interceptors.add(prettyDioLogger);
    var response = dio.get(url,options: _options);
    return response;
  }
}