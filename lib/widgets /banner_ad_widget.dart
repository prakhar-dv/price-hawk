import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2273231841018440/7668512461', 
      listener: BannerAdListener(),
      request: AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _ad == null
        ? SizedBox()
        : Container(
            width: _ad!.size.width.toDouble(),
            height: _ad!.size.height.toDouble(),
            child: AdWidget(ad: _ad!),
          );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}
