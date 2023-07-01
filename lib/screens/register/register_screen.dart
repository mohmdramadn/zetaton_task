import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/components/app_button.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/screens/register/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
        create: (_) => RegisterViewModel(
              connectionService: context.read<IConnectionService>(),
              messageService: context.read<IMessageService>(),
              firebaseService: context.read<IFirebaseService>(),
            ),
        child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _RegisterButton(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              SizedBox(height: 4.0.h),
              const _SubHeader(),
              const _UserDetailsFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    var isEnabled =
    context.select((RegisterViewModel vm) => vm.isButtonEnabled);
    var isLoading = context.select((RegisterViewModel vm) => vm.isLoading);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
        child: AppButton(
          onPressed: !isEnabled
              ? null
              : () =>
                  context.read<RegisterViewModel>().onRegisterSelectedAction(),
          child: isLoading
              ? SizedBox(
                  height: 15.h,
                  width: 15.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(Constant.titles.register),
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
        context.select((RegisterViewModel vm) => vm.emailController);
    var passwordController =
        context.select((RegisterViewModel vm) => vm.passwordController);
    var reEnterPasswordController =
        context.select((RegisterViewModel vm) => vm.reEnterPassController);
    var firstNameController =
        context.select((RegisterViewModel vm) => vm.firstNameController);
    var lastNameController =
        context.select((RegisterViewModel vm) => vm.lastNameController);
    var phoneController =
        context.select((RegisterViewModel vm) => vm.phoneController);

    var formKey =
        context.select((RegisterViewModel vm) => vm.formKey);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => context
          .read<RegisterViewModel>()
          .setButtonEnabledState(formKey.currentState!.validate()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(
            controller: firstNameController,
            labelText: Constant.titles.firstName,
            validator: (value) {
              var validationState =
              context.read<RegisterViewModel>().validateName(value!,true);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          _Field(
            controller: lastNameController,
            labelText: Constant.titles.lastName,
            validator: (value) {
              var validationState =
              context.read<RegisterViewModel>().validateName(value!,false);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          _Field(
            controller: emailController,
            labelText: Constant.titles.email,
            validator: (value) {
              var validationState =
                  context.read<RegisterViewModel>().validateEmail(value!);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          _Field(
            controller: passwordController,
            labelText: Constant.titles.password,
            obscureText: true,
            validator: (value) {
              var validationState =
              context.read<RegisterViewModel>().validatePassword(value!);
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          _Field(
            controller: reEnterPasswordController,
            labelText: Constant.titles.reEnterPassword,
            obscureText: true,
            validator: (value) {
              var validationState =
              context.read<RegisterViewModel>().validateConfirmPassword();
              if (validationState != "") return validationState;
              return null;
            },
          ),
          SizedBox(height: 16.0.h),
          _Field(
            controller: phoneController,
            labelText: Constant.titles.phoneNumber,
            validator: (value) {
              if (value!.isEmpty) {
                return Constant.titles.enterPhoneNumber;
              }
              // You can add additional validation logic here
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
      padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
      child: Text(
        Constant.titles.register,
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
        Constant.titles.registerSubHeader,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.labelText,
    required this.validator,
    required this.controller,
    this.obscureText = false,
  });

  final String labelText;
  final String? Function(dynamic value) validator;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Text(labelText,style: Theme.of(context).textTheme.bodySmall),
          ),
          SizedBox(height: 8.h,),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
            obscureText: obscureText,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
