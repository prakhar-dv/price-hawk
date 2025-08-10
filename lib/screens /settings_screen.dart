import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              value: isDarkMode,
              onChanged: (val) {
                setState(() {
                  isDarkMode = val;
                });
              },
              title: Text("Dark Mode", style: GoogleFonts.poppins()),
            ),
            ListTile(
              title: Text("Language", style: GoogleFonts.poppins()),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                items: ['English', 'Hindi'].map((lang) {
                  return DropdownMenuItem(
                    child: Text(lang),
                    value: lang,
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedLanguage = val!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Privacy Policy", style: GoogleFonts.poppins()),
              onTap: () {
                // Show privacy policy
              },
            ),
            ListTile(
              title: Text("Contact Admin", style: GoogleFonts.poppins()),
              subtitle: Text("prakhar.1833 (Instagram)\nprakharmishraspn91@gmail.com"),
            ),
           ListTile(
  leading: Icon(Icons.payment),
  title: Text('Donation / Premium'),
  onTap: () {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const DonationScreen(),
    ));
  },
),
            ),
          ],
        ),
      ),
    );
  }
}
