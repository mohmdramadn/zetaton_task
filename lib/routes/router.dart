import 'package:flutter/material.dart';
import 'package:zetaton_task/routes/routes_names.dart';
import 'package:zetaton_task/screens/register/register_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.registerRoute:
      return MaterialPageRoute(
          builder: (context) => const RegisterScreen(), settings: settings);

    default:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
  }
}