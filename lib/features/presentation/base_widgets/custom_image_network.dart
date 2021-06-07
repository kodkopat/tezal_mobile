import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_notifier.dart';

class CustomImageNetwork extends StatelessWidget {
  CustomImageNetwork({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var appNotifier = Get.find<AppNotifier>();

    return Image.network(
      imageUrl,
      headers: {"token": "${appNotifier.userToken}"},
      key: key ?? GlobalKey(),
      alignment: Alignment.center,
      fit: BoxFit.fill,
    );

/*
    CachedNetworkImage(
      cacheKey: "customerProfileImage",
      imageUrl: "${customerBaseApiUrl}Customer/getphoto",
      httpHeaders: {"token": "${appNotifier.userToken}"},
      alignment: Alignment.center,
      fit: BoxFit.fill,
    );
*/
  }
}
