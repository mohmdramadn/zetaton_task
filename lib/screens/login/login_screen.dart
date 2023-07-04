import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/components/app_button.dart';
import 'package:zetaton_task/components/app_fields.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/screens/login/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>.value(
        value: getIt<LoginViewModel>(), child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                SizedBox(height: 4.0.h),
                const _SubHeader(),
                const _UserDetailsFields(),
                SizedBox(height: 16.0.h),
                const _LoginButton(),
                const _Register(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: Constant.titles.doesNotHaveAccount),
            TextSpan(
              text: Constant.titles.register,
              style: TextStyle(fontFamily: Constant.fonts.nexaBold),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => context.read<LoginViewModel>().navigateToRegister(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    var isEnabled = context.select((LoginViewModel vm) => vm.isButtonEnabled);
    var isLoading = context.select((LoginViewModel vm) => vm.isLoading);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: AppButton(
          onPressed: !isEnabled
              ? null
              : () => context.read<LoginViewModel>().onLoginSelectedAction(),
          child: isLoading
              ? SizedBox(
                  height: 15.h,
                  width: 15.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(Constant.titles.login),
        ),
      ),
    );
  }
}

class _UserDetailsFields extends StatelessWidget {
  const _UserDetailsFields();

  @override
  Widget build(BuildContext context) {
    var emailController =
        context.select((LoginViewModel vm) => vm.emailController);
    var passwordController =
        context.select((LoginViewModel vm) => vm.passwordController);

    var formKey = context.select((LoginViewModel vm) => vm.formKey);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => context
          .read<LoginViewModel>()
          .setButtonEnabledState(formKey.currentState!.validate()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Field(
            controller: emailController,
            labelText: Constant.titles.email,
            validator: (value) {
              var validationState =
                  context.read<LoginViewModel>().validateEmail(value!);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          Field(
            controller: passwordController,
            labelText: Constant.titles.password,
            obscureText: true,
            validator: (value) {
              var validationState =
                  context.read<LoginViewModel>().validatePassword(value!);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 30.0.h),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0.h, right: 8.0.w, left: 8.0.w),
      child: Text(
        Constant.titles.login,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 8.0.w),
      child: Text(
        Constant.titles.loginSubHeader,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
