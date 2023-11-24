import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkService {
  static final DynamicLinkService _singleton = DynamicLinkService._internal();
  DynamicLinkService._internal();
  static DynamicLinkService get instance => _singleton;

  // 새로운 다이나믹 링크 생성
  void createDynamicLink(String path) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://linring.page.link/$path"),
      uriPrefix: "https://linring.page.link",
      androidParameters: const AndroidParameters(packageName: "com.linring"),
      iosParameters:
          const IOSParameters(bundleId: "com.example.linringFrontFlutter"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    debugPrint("${dynamicLink.shortUrl}");
  }
}
