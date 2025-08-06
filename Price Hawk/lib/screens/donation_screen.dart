import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/native_ad_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TrackedProductsScreen extends StatefulWidget {
  const TrackedProductsScreen({super.key});

  @override
  State<TrackedProductsScreen> createState() => _TrackedProductsScreenState();
}

class _TrackedProductsScreenState extends State<TrackedProductsScreen> {
  late NativeAd nativeAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadNativeAd();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-2273231841018440/4794937116', // 👈 Replace with real ID
      factoryId: 'listTile',
      r…
[12:17 am, 6/8/2025] 😎 🥰: import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  final String upiId = 'ranjeetmishraspn@oksbi';

  void _launchUPI(String amount) async {
    final Uri uri = Uri.parse(
      'upi://pay?pa=$upiId&pn=PriceHawk&cu=INR&am=$amount',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch UPI payment';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'hi' ? 'डोनेशन / प्रीमियम' : 'Donation / Premium'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              lang == 'hi'
                  ? 'ऐप को प्रीमियम बनाएं और ऐड हटाएं:'
                  : 'Go Premium and remove ads:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _launchUPI("299"),
              child: Text(lang == 'hi'
                  ? '₹299 - 60 दिन के लिए प्रीमियम'
                  : '₹299 - Premium for 60 Days'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => _launchUPI("999"),
              child: Text(lang == 'hi'
                  ? '₹999 - 1 साल के लिए प्रीमियम'
                  : '₹999 - Premium for 1 Year'),
            ),
            const SizedBox(height: 30),

            Divider(),
            const SizedBox(height: 10),

            Text(
              lang == 'hi'
                  ? 'डोनेशन के लिए:'
                  : 'For Donations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            SelectableText(
              upiId,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.amberAccent : Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}