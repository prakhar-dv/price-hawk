import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/tracked_products_screen.dart';
import 'screens/login_screen.dart';
import 'screens/premium_screen.dart';
import 'backend/firestore_helper.dart';
import 'backend/notification_service.dart';
import 'backend/firebase_service.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'localization/app_localizations.dart';
import 'ads/ad_helper.dart';
import 'widgets/premium_button.dart';
import 'screens/donation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const PriceHawkApp(),
    ),
  );
}

class PriceHawkApp extends StatelessWidget {
  const PriceHawkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Hawk',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('hi', ''), // Hindi
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}