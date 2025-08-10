import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-2273231841018440/7668512461', 
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Price Hawk 🦅"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      body: Column(
        children: [
          if (_bannerAd != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          const SizedBox(height: 20),
          Text(
            locale.trackYourDeals,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/track');
            },
            icon: const Icon(Icons.add),
            label: Text(locale.trackNewProduct),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
            icon: const Icon(Icons.history),
            label: Text(locale.viewTracked),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/premium');
            },
            icon: const Icon(Icons.star),
            label: Text(locale.goPremium),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/donate');
            },
            icon: const Icon(Icons.volunteer_activism),
            label: Text(locale.donate),
          ),
        ],
      ),
    );
  }
}
