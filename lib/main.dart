import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:utcc_mobile/provider/user_login_provider.dart';
import 'package:utcc_mobile/screens/authentication/login.dart';
import 'package:utcc_mobile/screens/authentication/pin.dart';

void main() {
  configLoading();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserLoginProvider()),
    ],
    child: MyApp(),
  ));
}

void configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..fontSize = 20
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black12
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'prompt',
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: Locale('th', 'TH'),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('th', 'TH'),
      ],
      initialRoute: '/Login',
      routes: {
        // ignore: dead_code
        '/Login': (_) => Login(),
      },
      builder: EasyLoading.init(builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
              textScaleFactor: mediaQueryData.textScaleFactor.clamp(1.1, 1.1)),
          child: child!,
        );
      }),
    );
  }
}
