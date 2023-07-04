import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/helper/shared_pref.dart';
import 'package:zetaton_task/routes/routes_names.dart';

@injectable
class SplashViewModel extends ChangeNotifier{
  final IFirebaseService firebaseService;

  SplashViewModel({required this.firebaseService});

  bool get isLoggedInOnFirebase =>  firebaseService.checkIfLoggedIn();

  void isUserLoggedIn(){
    if(isLoggedInOnFirebase){
      var user = firebaseService.getCurrentUserInfo();
      Preference.instance.saveData(Constant.sharedPrefKeys.user, user);
      Get.offAndToNamed(Routes.homeRoute);
      return;
    }
    Get.offAndToNamed(Routes.loginRoute);
  }
}