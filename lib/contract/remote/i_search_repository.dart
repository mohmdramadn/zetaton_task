import 'package:async/async.dart';

abstract class ISearchRepository {
  Future<Result> getSearchedPhotos(
      {required int numberOfPhotos, required String searchParam});
}