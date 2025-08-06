import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final _db = FirebaseFirestore.instance;

  /// 🧹 Automatically delete old data based on premium plan
  static Future<void> deleteOldUserData(String userId) async {
    final snapshot = await _db
        .collection('tracked_products')
        .where('userId', isEqualTo: userId)
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final timestamp = (data['timestamp'] as Timestamp).toDate();
      final isPremium = data['premium'] as bool? ?? false;
      final premiumDuration = data['premiumDuration'] as int? ?? 0;

      // 🗓️ Delete after X months
      int extraMonths = isPremium
          ? (premiumDuration == 365 ? 14 : 6) // 1 year = 14mo, 2mo = 6mo
          : 6;

      final deleteBefore = DateTime.now().subtract(Duration(days: extraMonths * 30));

      if (timestamp.isBefore(deleteBefore)) {
        await _db.collection('tracked_products').doc(doc.id).delete();
      }
    }
  }
}