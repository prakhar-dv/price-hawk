import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({super.key});

  void copyUPI(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'ranjeetmishraspn@oksbi'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ UPI ID copied: ranjeetmishraspn@oksbi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Go Premium & Remove Ads',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('₹299 for 60 days OR ₹999 for 1 year'),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => copyUPI(context),
              icon: const Icon(Icons.copy),
              label: const Text('Pay via UPI: ranjeetmishraspn@oksbi'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
