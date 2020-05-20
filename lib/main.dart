import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiclinic/routes/route_constants.dart';
import 'localization/app_localization.dart';
import 'package:multiclinic/routes/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multiclinic/localization/langauge_localization.dart';

Future main() async
{
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,

]);

  runApp(FlutterLocalization());
}

class FlutterLocalization extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _FlutterLocalizationState state =
    context.findAncestorStateOfType<_FlutterLocalizationState>();
    state.setLocale(newLocale);
  }

  @override
  _FlutterLocalizationState createState() => _FlutterLocalizationState();
}

class _FlutterLocalizationState extends State<FlutterLocalization> {
  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
   locale=_locale;//_locale=locale;
    });
  }

  @override
  void didChangeDependencies() {
    this._fetchLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name',
        theme: ThemeData(primaryColor: Colors.blue[800]),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'AR'),
          Locale('ku','KU'),
        ],
        locale: _locale,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: startupRoute,
        onGenerateRoute: Router.generatedRoute,
      );
    }
  }

  _fetchLocale() async {
    Locale tempLocale;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = (prefs.getString(LANGUAGE_CODE) ?? 'en');

    switch (languageCode) {
      case ENGLISH:
        tempLocale = Locale(ENGLISH, 'US');
        break;
      case ARABIC:
        tempLocale = Locale(ARABIC, 'AR');
        break;
      case KURDISH:
        tempLocale=Locale(KURDISH,'KU');
        break;
      default:
        tempLocale = Locale(ENGLISH,"US");
    }
    return tempLocale;
  }
}