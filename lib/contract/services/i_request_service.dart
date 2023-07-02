import 'package:dio/dio.dart';

abstract class IRequestService{
  Future<Response> getRequest(String url);
}