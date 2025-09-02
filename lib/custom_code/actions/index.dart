import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

Future<void> shareToPlatform(String platform, String referralCode) async {
  if (referralCode.isEmpty) return;

  final baseUrl = 'https://fulboost.com/signup?ref=$referralCode';
  final text =
      'Join Ful2Win and earn rewards using my code: $referralCode - $baseUrl';

  String shareUrl = '';

  switch (platform.toLowerCase()) {
    case 'whatsapp':
      shareUrl = 'https://wa.me/?text=${Uri.encodeComponent(text)}';
      break;
    case 'telegram':
      shareUrl =
          'https://t.me/share/url?url=${Uri.encodeComponent(baseUrl)}&text=${Uri.encodeComponent(text)}';
      break;
    default:
      // Fallback to the landing URL if platform not recognized
      shareUrl = baseUrl;
  }

  if (shareUrl.isEmpty) {
    // Extra guard: fallback to baseUrl
    shareUrl = baseUrl;
  }

  final uri = Uri.parse(shareUrl);

  // Open link in external application (works for Web & Mobile)
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $shareUrl';
  }
}

Future<void> copyToClipboard(String text) async {
  if (text.isEmpty) {
    print('Nothing to copy');
    return;
  }

  await Clipboard.setData(ClipboardData(text: text));
  print('Copied to clipboard: $text');
}
