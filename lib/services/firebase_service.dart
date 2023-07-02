import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';

@Singleton(as: IFirebaseService)
class FirebaseService implements IFirebaseService{
  final firebaseAuth = FirebaseAuth.instance;
  User? user;

  @override
  Future<Result<User>> signupNewUserAsync(String email, String password) async {
    try {
      var response = await firebaseAuth.createUserWithEmailAndPassword(
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

  // Future<Result<String>> createProfileAsync(
  //     {required UserProfileModel model}) async {
  //   final newUser = <String, dynamic>{
  //     'uid': user?.uid,
  //     'Email': user?.email,
  //     'Full name': model.fullName,
  //     'username': model.username,
  //     'Gender': model.gender,
  //     'Height': model.height,
  //     'Age': model.age,
  //     'Muscles Percentage': model.musclesPercentage,
  //     'Water Percentage': model.waterPercentage,
  //     'Fats Percentage': model.fatsPercentage,
  //     'Join Date': model.joinDate,
  //     'Next session': model.nextSession
  //   };
  //   try {
  //     await database.collection('users_profile').doc(user?.uid).set(newUser);
  //     await addNewUserNameAsync(displayName: model.fullName);
  //     return Result.value(user!.uid);
  //   } catch (e) {
  //     return Result.error(e);
  //   }
  // }

  // Future<Result<UserProfileModel>> getUserProfile() async {
  //   try {
  //     var profile = await database
  //         .collection('users_profile')
  //         .where('uid', isEqualTo: user?.uid)
  //         .get();
  //     UserProfileModel userProfile =
  //     UserProfileModel.fromFirestore(profile.docs.first.data());
  //
  //     return Result.value(userProfile);
  //   } catch (e) {
  //     return Result.error(e);
  //   }
  // }

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
}