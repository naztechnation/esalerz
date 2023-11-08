import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/view_models/account_view_model.dart';
import 'model/view_models/user_view_model.dart';
import 'provider/items.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PageIndexProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
       ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
    ],
    child: const Esalerz(),
  ), );
}

class Esalerz extends StatelessWidget {
  const Esalerz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
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
