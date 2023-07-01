import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/firebase_options.dart';
import 'package:zetaton_task/providers.dart';
import 'package:zetaton_task/routes/router.dart';
import 'package:zetaton_task/routes/routes_names.dart';
import 'package:zetaton_task/theme/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      builder: (context, child) => MultiProvider(
        providers: provider,
        child: GetMaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'Wallpaper Gallery',
          theme: ThemeData(
            colorScheme: lightColorScheme,
            textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
          ),
          onGenerateRoute: onGenerateRoute,
          initialRoute: Routes.registerRoute,
          opaqueRoute: Get.isOpaqueRouteDefault,
          color: Colors.white,
        ),
      )
    );
  }
}
