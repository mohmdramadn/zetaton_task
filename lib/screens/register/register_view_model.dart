import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/helper/validator.dart';

@injectable
class RegisterViewModel extends ChangeNotifier {
  final IConnectionService connectionService;
  final IFirebaseService firebaseService;
  final IMessageService messageService;

  RegisterViewModel({
    required this.connectionService,
    required this.firebaseService,
    required this.messageService,
  });

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPassController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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

  Future<void> onRegisterSelectedAction() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
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
    setLoadingState(true);
    var signUpResponse = await firebaseService.signupNewUserAsync(
        emailController.text, passwordController.text);
    if (signUpResponse.isError) {
      setLoadingState(false);
      messageService.showErrorSnackBar(
        '',
        signUpResponse.asError!.error.toString(),
      );
      return;
    }
    setLoadingState(false);
    notifyListeners();
  }

  String validatePhone(String phone) {
    var phoneValidationResult = Validator.isValidPhone(phone);
    if (phoneValidationResult == Constant.phoneValidationStatus.isEmpty) {
      return Constant.phoneValidationStatus.isEmpty;
    }
    if (phoneValidationResult == Constant.phoneValidationStatus.isNotNumber) {
      return Constant.phoneValidationStatus.isNotNumber;
    }
    return "";
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

  String validateConfirmPassword() {
    var passwordValidationResult = Validator.isValidConfirmPassword(
      password: passwordController.text,
      confirmPassword: reEnterPassController.text,
    );
    if (passwordValidationResult ==
        Constant.reEnterPasswordValidationStatus.isEmpty) {
      return Constant.reEnterPasswordValidationStatus.isEmpty;
    }
    if (passwordValidationResult ==
        Constant.reEnterPasswordValidationStatus.isNotMatching) {
      return Constant.reEnterPasswordValidationStatus.isNotMatching;
    }
    return "";
  }

  String validateName(String name, bool isFirstName) {
    var nameValidationResult = Validator.isValidName(name);
    if (!nameValidationResult) {
      if (isFirstName) {
        return Constant.titles.firstNameEmpty;
      }
      return Constant.titles.lastNameEmpty;
    }
    return "";
  }
}
