// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lastversion/Home.dart';
import 'package:lastversion/Smart.dart';
import 'package:lastversion/mainpage.dart';
import 'package:lastversion/notifications/notification_api.dart';
import 'package:lastversion/profile.dart';
import 'package:lastversion/realtime_db.dart';
import 'package:lastversion/roomdetails.dart';
import 'package:lastversion/notifications/notifications.dart';
import 'package:lastversion/services/APIServices.dart';
import 'package:lastversion/smart_pages/poweron.dart';
import 'package:lastversion/smart_pages/sunset.dart';
import 'package:lastversion/timer/test.dart';
import 'package:lastversion/timer/timer.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lastversion/provider/provider.dart';

final APIServices apiServices = APIServices();

//import 'package:responsive_framework/responsive_framework.dart';

//sethompage back the defult but now test the smart page
//import 'Home.dart';

// void main() {
//   runApp(const MaterialApp(home: MainPage()));
// }

Future<void> main() async {
  Future initialization(BuildContext? context) async {
    await Future.delayed(Duration(seconds: 1));
  }

  FlutterNativeSplash.removeAfter(initialization);

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => LocalProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocalProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
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
