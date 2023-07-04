import 'package:flutter/material.dart';
import 'package:zetaton_task/models/photos.dart';
import 'package:zetaton_task/routes/routes_names.dart';
import 'package:zetaton_task/screens/favorites/favorites_screen.dart';
import 'package:zetaton_task/screens/home/home_screen.dart';
import 'package:zetaton_task/screens/login/login_screen.dart';
import 'package:zetaton_task/screens/photo_details/photo_details_screen.dart';
import 'package:zetaton_task/screens/register/register_screen.dart';
import 'package:zetaton_task/screens/splash/splash_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.registerRoute:
      return MaterialPageRoute(
          builder: (context) => const RegisterScreen(), settings: settings);

    case Routes.loginRoute:
      return MaterialPageRoute(
          builder: (context) => const LoginScreen(), settings: settings);

    case Routes.homeRoute:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);

    case Routes.photoDetailsRoute:
      var photo = settings.arguments as Photos;
      return MaterialPageRoute(
        builder: (context) => PhotoDetailsScreen(photo: photo),
        settings: settings,
      );

    case Routes.favoritesRoute:
      return MaterialPageRoute(
          builder: (context) => const FavoritesScreen(), settings: settings);

    case Routes.splashRoute:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: settings);

    default:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
  }
}