import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/localization/def_string_base.dart';
import 'package:flutter_demo/github/language/cn_string.dart';
import 'package:flutter_demo/github/language/en_string.dart';

///多语言实现
class DefLocalizations {
  final Locale locale;

  DefLocalizations(this.locale);

  static Map<String, DefStringBase> _localizedValues = {
    "en":EnString(),
    "zh":CnString(),
  };

  ///    'en': new StringEn(),
  ///    'zh': new StringZh(),
  static set(key, value) {
    _localizedValues[key] = value;
  }

  DefStringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues['en'];
  }

  static DefLocalizations of(BuildContext context) {
    return Localizations.of(context, DefLocalizations);
  }

  static DefStringBase i18n(BuildContext context) {
    return (Localizations.of(context, DefLocalizations) as DefLocalizations)
        .currentLocalized;
  }
}
