import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChanged;

  const LanguageSwitcher({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language),
      items: const [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: Locale('hi'),
          child: Text('हिन्दी'),
        ),
      ],
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          onLocaleChanged(newLocale);
        }
      },
    );
  }
}
