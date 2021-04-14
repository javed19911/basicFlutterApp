import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intello_track_image_upload_app/res/string/Strings.dart';
import 'package:intello_track_image_upload_app/route_generator.dart';

import 'data/AppDataManager.dart';
import 'multiLanguage/localization_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String createdPrivacyPolicy = 'privacy_policy';
  static String createdTermsOfUses = 'terms_of_uses';

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  AppDataManager _dataManager = AppDataManager();
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void didChangeDependencies() async {
    _dataManager.getSelectedLanguage().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF038a75),
        accentColor: const Color(0xFFFFAD32),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      locale: _locale,
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
        Locale('kn')
      ],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
