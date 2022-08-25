import 'package:url_launcher/url_launcher.dart';

class LoadUrl {
  void loadUrl(String link) async {
    await launchUrl(Uri.parse(link));
  }
}
