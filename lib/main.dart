import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zetaton_task/firebase_options.dart';
import 'package:zetaton_task/main.config.dart';
import 'package:zetaton_task/routes/router.dart';
import 'package:zetaton_task/routes/routes_names.dart';
import 'package:zetaton_task/theme/theme.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Wallpaper Gallery',
        theme: appThemeData,
        onGenerateRoute: onGenerateRoute,
        initialRoute: Routes.loginRoute,
        opaqueRoute: Get.isOpaqueRouteDefault,
        color: Colors.white,
      )
    );
  }
}
