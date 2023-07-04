import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';

@Singleton(as: IFirebaseService)
class FirebaseService implements IFirebaseService{
  final firebaseAuth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  User? user;

  @override
  Future<Result<User>> signupNewUserAsync(String email, String password,
      String fullName) async {
    try {
      var response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
      createProfileAsync(fullName: fullName);
      return Result.value(response.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.message!);
    }
  }

  @override
  Future<Result<User>> loginAsync(String email, String password) async {
    try {
      var response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
      return Result.value(response.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.message!);
    }
  }

  @override
  Future<Result<bool>> logoutAsync() async {
    try {
      await firebaseAuth.signOut();
      return Result.value(true);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return Result.error(false);
    } catch (e) {
      log(e.toString());
      return Result.error(false);
    }
  }

  @override
  Future<Result<bool>> addNewUserNameAsync({String? displayName}) async {
    try {
      await user?.updateDisplayName(displayName);
      return Result.value(true);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<String>> createProfileAsync({required String fullName}) async {
    final newUser = <String, dynamic>{
      Constant.firebaseQueryParam.uid: user?.uid,
      Constant.firebaseQueryParam.fullName: fullName,
      Constant.firebaseQueryParam.favorites: []
    };
    try {
      await database.collection(Constant.firebaseQueryParam.users).doc(user?.uid).set(newUser);
      await addNewUserNameAsync(displayName: fullName);
      return Result.value(user!.uid);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> updateFavoritesAsync(
      {required List<String> photos}) async {
    try {
      await database
          .collection(Constant.firebaseQueryParam.users)
          .doc(user?.uid)
          .update({Constant.firebaseQueryParam.favorites: FieldValue.arrayUnion(photos)});
      return Result.value(true);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<QuerySnapshot<Map<String, dynamic>>>> getFavoritePhotos() async {
    try {
      var response = await database
          .collection(Constant.firebaseQueryParam.users)
          .where(Constant.firebaseQueryParam.uid, isEqualTo: user?.uid)
          .get();

      return Result.value(response);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  User? getCurrentUserInfo() {
    return user = firebaseAuth.currentUser;
  }

  @override
  bool checkIfLoggedIn() {
    if (firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> updateUserDisplayName(String fullName) async {
    await firebaseAuth.currentUser?.updateDisplayName(fullName);
  }
}