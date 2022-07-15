
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The current Language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signin;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get signemail;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @appleid.
  ///
  /// In en, this message translates to:
  /// **'AppleID'**
  String get appleid;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Control from'**
  String get control;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'anywhere'**
  String get anywhere;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to terms and conditions'**
  String get by;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome !'**
  String get welcome;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sign in to control your lights'**
  String get signincontrol;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get pass;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Forgot password ? '**
  String get forget;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account ?'**
  String get donthave;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sign up to control your lights'**
  String get signupcontrol;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmpass;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Already have account ?'**
  String get haveacc;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Invalid password '**
  String get invalidpass;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Enter correct email'**
  String get entercorrect;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passrequir;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get erequir;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'No rooms yet ... '**
  String get noroomsyet;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Home '**
  String get myhome;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get smart;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Automation '**
  String get auto;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Scheduled Power-On '**
  String get spoweron;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Scheduled Power-off '**
  String get spoweroff;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'scheduled-notifications'**
  String get snotify;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Turn off the switch at sunrise '**
  String get sunrise;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **' Turn on the switch at sunset '**
  String get sunset;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Notifications '**
  String get notify;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Turn-on notifications'**
  String get turnnotify;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Set your location'**
  String get setloc;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Check your report'**
  String get checkre;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Password must be atleast 8 characters '**
  String get passvalid;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Passwords need to match '**
  String get passmatch;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Autmoation Details'**
  String get autodetails;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Manual Control'**
  String get manual;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Enater your light alias'**
  String get enteralias;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Edit light name'**
  String get editlight;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Enter new light name'**
  String get newname;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'No light yet ...'**
  String get nolight;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Pick a time'**
  String get pick;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Feature is added successfully!'**
  String get added;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Power-off'**
  String get poweroff;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Power-off at:'**
  String get offat;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Select one room or more :'**
  String get selectnum;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get set;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Power-on'**
  String get poweron;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Power-on at :'**
  String get onat;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Notify me after:'**
  String get notifyaftr;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrisesm;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Switch off lights at sunrise'**
  String get switchsunrise;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sunrise is at :  5:35 am'**
  String get suriseat;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Switch on lights at sunset'**
  String get switchsunset;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sunset is at :  7:46 pm'**
  String get sunsetat;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunsetsm;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'New Light'**
  String get newlight;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Automation Details'**
  String get autode;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'No automation details yet..'**
  String get noauto;

  /// A programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetpass;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
