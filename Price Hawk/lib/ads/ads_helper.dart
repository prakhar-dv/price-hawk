import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static String get bannerAdUnitId => 'ca-app-pub-2273231841018440/7668512461';
  static String get interstitialAdUnitId => 'ca-app-pub-2273231841018440/1498674027';
  static String get nativeAdUnitId => 'ca-app-pub-2273231841018440/4794937116';
  static String get appOpenAdUnitId => 'ca-app-pub-2273231841018440/7229528764';

  static initializeAds() {
    MobileAds.instance.initialize();
  }

  static BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('✅ Banner Ad Loaded'),
        onAdFailedToLoad: (ad, error) {
          print('❌ Failed to load banner ad: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  static InterstitialAd? _interstitialAd;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print('✅ Interstitial Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          print('❌ Failed to load interstitial ad: $error');
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      loadInterstitialAd(); // pre-load next
    }
  }
}