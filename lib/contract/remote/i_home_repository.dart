import 'package:async/async.dart';
import 'package:zetaton_task/models/page.dart';

abstract class IHomeRepository {
  Future<Result<Page>> getPhotos({required int numberOfPhotos});
}
