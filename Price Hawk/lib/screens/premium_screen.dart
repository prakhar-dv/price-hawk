import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumScreen extends StatelessWidget {
  final bool isHindi;
  const PremiumScreen({super.key, required this.isHindi});

  final String upiId = "ranjeetmishraspn@oksbi";

  void copyUPI(BuildContext context) {
    Clipboard.setData(ClipboardData(text: upiId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isHindi ? "UPI ID कॉपी हुई" : "UPI ID copied")),
    );
  }

  void launchUPIPayment() async {
    final uri = Uri.parse("upi://pay?pa=$upiId&pn=PriceHawk%20Premium");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "प्रीमियम योजना" : "Premium Plans"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              isHindi
                  ? "विज्ञापन हटाएं और प्राइस ट्रैकिंग का अधिक लाभ लें।"
                  : "Remove ads and enjoy full tracking features.",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            PremiumCard(
              title: isHindi ? "₹299 / 60 दिन" : "₹299 / 60 days",
              description: isHindi
                  ? "2 महीने के लिए विज्ञापन मुक्त अनुभव।"
                  : "Ad-free experience for 2 months.",
              onTap: launchUPIPayment,
            ),

            const SizedBox(height: 20),

            PremiumCard(
              title: isHindi ? "₹999 / 1 साल" : "₹999 / 1 Year",
              description: isHindi
                  ? "पूरे 1 साल तक बिना किसी विज्ञापन के।"
                  : "No ads for a full year.",
              onTap: launchUPIPayment,
            ),

            const SizedBox(height: 30),

            Text(
              "${isHindi ? "भुगतान UPI ID:" : "Payment UPI ID:"} $upiId",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => copyUPI(context),
              icon: const Icon(Icons.copy),
              label: Text(isHindi ? "कॉपी करें" : "Copy"),
            )
          ],
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const PremiumCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(description, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}