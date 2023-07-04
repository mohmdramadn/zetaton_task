import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/screens/splash/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>.value(
        value: getIt<SplashViewModel>(), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future.microtask(() => context.read<SplashViewModel>().isUserLoggedIn());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
