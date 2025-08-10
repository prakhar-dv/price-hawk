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
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) => setState(() => isAdLoaded = true),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    nativeAd.load();
  }

  @override
  void dispose() {
    nativeAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Tracked Products")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tracked_products")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: docs.length + (isAdLoaded ? 1 : 0),
            separatorBuilder: (, _) => Divider(),
            itemBuilder: (context, index) {
              if (isAdLoaded && index == 1) {
                return NativeAdWidget(nativeAd: nativeAd);
              }

              final actualIndex = isAdLoaded && index > 1 ? index - 1 : index;
              final data = docs[actualIndex].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['product'] ?? "No name"),
                subtitle: Text("₹${data['price'] ?? 'Unknown'}"),
                trailing: Text(
                  (data['timestamp'] as Timestamp).toDate().toString().split(" ").first,
                  style: TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
