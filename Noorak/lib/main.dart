import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lastversion/mainpage.dart';
import 'package:lastversion/services/APIServices.dart';
import 'package:lastversion/services/NavService.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lastversion/provider/provider.dart';

final APIServices apiServices = APIServices();

NavigationService navigationSerivce = NavigationService();

void main() async {
  // Future initialization(BuildContext? context) async {
  //   await Future.delayed(Duration(seconds: 1));
  // }
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // runApp(const MaterialApp(home: MainPage()));

  FlutterNativeSplash.remove();

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => LocalProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocalProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigationSerivce.navigatorKey,
           onGenerateRoute: (settings) => generateRoute(settings),
          initialRoute: '/',
          // home: MainPage(),
          supportedLocales: L10n.all,
          locale: provider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
          ],
        );
      }));
}
