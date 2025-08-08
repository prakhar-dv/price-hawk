import 'package:cloud_firestore/cloud_firestore.dart';

class PriceTracker {
  static final _db = FirebaseFirestore.instance;

  /// 📝 Track new product
  static Future<void> trackProduct({
    required String userId,
    required String productName,
    required double price,
    required bool isPremium,
    required int premiumDuration, // 60 or 365
  }) async {
    await _db.collection('tracked_products').add({
      'userId': userId,
      'product': productName,
      'price': price,
      'timestamp': DateTime.now(),
      'premium': isPremium,
      'premiumDuration': premiumDuration,
    });
  }

  /// 📦 Get all products tracked by current user
  static Future<List<Map<String, dynamic>>> getUserProducts(String userId) async {
    final snapshot = await _db
        .collection('tracked_products')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
