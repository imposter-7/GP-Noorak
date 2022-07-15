import 'package:flutter/cupertino.dart';
import 'package:lastversion/l10n/l10n.dart';
class LocalProvider extends ChangeNotifier
{
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale? locale)
  {
    if(!L10n.all.contains(locale)) return;
    print(locale!.languageCode);
    _locale = locale;
    notifyListeners();
  } 
}
