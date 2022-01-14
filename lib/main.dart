import 'dart:convert';

import 'package:basic_flutter_app/utils/freecharge/gateway_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/AppDataManager.dart';
import 'multiLanguage/localization_delegate.dart';
import 'res/string/Strings.dart';
import 'route_generator.dart';
import 'package:crypto/crypto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String createdPrivacyPolicy = 'privacy_policy';
  static String createdTermsOfUses = 'terms_of_uses';

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  AppDataManager _dataManager = AppDataManager();
  void setLocale(Locale locale) {
    _dataManager.setLanguage(locale.languageCode);
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
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: () {
          return MaterialApp(
            title: Strings.app_name,
            theme: ThemeData(
              brightness: Brightness.light,
              textTheme: GoogleFonts.poppinsTextTheme(),
              canvasColor: Colors.transparent,
              // primaryColor: const Color(0xFF02BB9F),
              // canvasColor: const Color(0xFF038a75),
              // accentColor: const Color(0xFFFFAD32),
            ),
            // home: GatewayWebView(),
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
            locale: _locale,
            supportedLocales: [
              Locale('en'),
              Locale('hi'),
              Locale('mr'),
              Locale('as'),
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
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          );
        });
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
