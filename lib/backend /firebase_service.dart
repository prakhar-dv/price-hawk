import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firestore_helper.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;

  /// 🔐 Returns current user ID
  static String? getUserId() => _auth.currentUser?.uid;

  /// ✅ Sign in with Google
  static Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account == null) return null; // Cancelled

    final auth = await account.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    // 🔁 Clean old data if needed
    await FirestoreHelper.deleteOldUserData(userCredential.user!.uid);

    return userCredential.user;
  }

  /// 🚪 Sign out
  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  /// 🔍 Is user premium?
  static Future<bool> isPremiumUser(String userId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (!userDoc.exists) return false;

    final data = userDoc.data();
    return data?['premium'] == true;
  }
}
