import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';

abstract class IFirebaseService {
  Future<Result<User>> signupNewUserAsync(String email, String password,String fullName);

  Future<Result<User>> loginAsync(String email, String password);

  Future<Result<String>> createProfileAsync({required String fullName});

  Future<Result<bool>> addNewUserNameAsync({String? displayName});

  Future<Result<bool>> updateFavoritesAsync({required List<String> photos});

  Future<void> updateUserDisplayName(String fullName);

  Future<Result<bool>> logoutAsync();

  User? getCurrentUserInfo();

  bool checkIfLoggedIn();
}
