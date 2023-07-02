import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';

abstract class IFirebaseService {
  Future<Result<User>> signupNewUserAsync(String email, String password);

  Future<Result<User>> loginAsync(String email, String password);

  Future<Result<bool>> logoutAsync();

  User? getCurrentUserInfo();

  bool checkIfLoggedIn();
}
