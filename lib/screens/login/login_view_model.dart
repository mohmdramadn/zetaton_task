import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/helper/validator.dart';

class LoginViewModel extends ChangeNotifier {
  final IConnectionService connectionService;
  final IFirebaseService firebaseService;
  final IMessageService messageService;

  LoginViewModel({
    required this.connectionService,
    required this.firebaseService,
    required this.messageService,
  });

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;
  void setButtonEnabledState(value) {
    _isButtonEnabled = value;
    notifyListeners();
  }

  Future<void> onLoginSelectedAction() async {
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      setLoadingState(false);
      Fluttertoast.showToast(
        msg: Constant.titles.notConnected,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0.spMin,
      );
      return;
    }
    var loginResponse = await firebaseService.loginAsync(
        emailController.text, passwordController.text);
    if (loginResponse.isError) {
      setLoadingState(false);
      messageService.showErrorSnackBar(
        '',
        loginResponse.asError!.error.toString(),
      );
      return;
    }
    setLoadingState(false);
    notifyListeners();
  }

  String validateEmail(String email) {
    var emailValidationResult = Validator.isValidEmail(email);
    if (!emailValidationResult) {
      return Constant.emailValidationStatus.isNotValid;
    }
    return "";
  }

  String validatePassword(String password) {
    var passwordValidationResult = Validator.isValidPassword(password);
    if (passwordValidationResult == Constant.passwordValidationStatus.isEmpty) {
      return Constant.passwordValidationStatus.isEmpty;
    }
    return "";
  }
}
