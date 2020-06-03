import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_demo/base/localization/def_localizations.dart';

class YeLocalizationsDelegate extends LocalizationsDelegate<DefLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<DefLocalizations> load(Locale locale) {
    return new SynchronousFuture(new DefLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DefLocalizations> old) {
    return false;
  }

  static YeLocalizationsDelegate delegate = new YeLocalizationsDelegate();
}
