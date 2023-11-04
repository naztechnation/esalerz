import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'provider/items.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PageIndexProvider(),
      child: const Esalerz(),
    ),
  );
}

class Esalerz extends StatelessWidget {
  const Esalerz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: AppStrings.urbanist),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
