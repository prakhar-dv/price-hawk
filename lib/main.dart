import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:price_hawk/l10n/app_localizations.dart';
import 'package:price_hawk/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('theme') ?? 'system';
  final savedLang = prefs.getString('language') ?? 'en';

  runApp(PriceHawkApp(
    themeMode: _getThemeMode(savedTheme),
    locale: Locale(savedLang),
  ));
}

ThemeMode _getThemeMode(String theme) {
  switch (theme) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

class PriceHawkApp extends StatefulWidget {
  final ThemeMode themeMode;
  final Locale locale;

  const PriceHawkApp({super.key, required this.themeMode, required this.locale});

  @override
  State<PriceHawkApp> createState() => _PriceHawkAppState();
}

class _PriceHawkAppState extends State<PriceHawkApp> {
  late ThemeMode _themeMode;
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
    _locale = widget.locale;
  }

  void _updateTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    setState(() => _themeMode = _getThemeMode(theme));
  }

  void _updateLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    setState(() => _locale = Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Hawk',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('hi')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(
        onThemeChanged: _updateTheme,
        onLanguageChanged: _updateLanguage,
      ),
    );
  }
}
