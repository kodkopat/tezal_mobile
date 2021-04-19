// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_pages/dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  static const route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final repository = AuthRepository();
  VideoPlayerController videoPlayerController = VideoPlayerController.asset(
    "assets/videos/tezal_splash_animation.mp4",
  );

  void initializeState() async {
    final _authRepository = AuthRepository();
    _AppUserType userType;

    final userId = await repository.userId;
    print("userId = $userId\n");

    final userToken = await repository.userToken;
    print("userToken = $userToken\n");

    final value = await _authRepository.userType;
    if (value != null && value.isNotEmpty) {
      userType = _AppUserTypeParser.fromString(value);
    } else {
      userType = _AppUserType.Customer;
    }

    switch (userType) {
      case _AppUserType.Customer:
        Routes.sailor.navigate(
          DashBoardPage.route,
          navigationType: NavigationType.pushReplace,
        );
        break;
      case _AppUserType.Market:
        // Routes.sailor(CustomerDashBoardPage.route);
        break;
      case _AppUserType.Delivery:
        // Routes.sailor(CustomerDashBoardPage.route);
        break;
    }

    // videoPlayerController.addListener(() {
    //   var playerValue = videoPlayerController.value;
    //   if (playerValue.position == playerValue.duration) {

    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    // videoPlayerController.setLooping(true);
    videoPlayerController
      ..initialize().then((value) {
        setState(() {});
        videoPlayerController.play();
      });

    videoPlayerController.addListener(() {
      var playerValue = videoPlayerController.value;
      if (playerValue.position == playerValue.duration) {
        initializeState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: videoPlayerController.value.isInitialized
          ? VideoPlayer(videoPlayerController)
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}

enum _AppUserType {
  Customer,
  Market,
  Delivery,
}

class _AppUserTypeParser {
  static const _customerKey = "customer";
  static const _marketKey = "market";
  static const _deliveryKey = "delivery";

  static _AppUserType fromString(String userType) {
    if (userType.trim().isEmpty) return _AppUserType.Customer;

    switch (userType.toLowerCase()) {
      case _customerKey:
        return _AppUserType.Customer;
      case _marketKey:
        return _AppUserType.Market;
      case _deliveryKey:
        return _AppUserType.Delivery;
      default:
        return _AppUserType.Customer;
    }
  }
}
