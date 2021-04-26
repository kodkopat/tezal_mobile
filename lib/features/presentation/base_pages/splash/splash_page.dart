// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../features/presentation/base_pages/encourage_login/encourage_login_page.dart';
import '../../../data/models/app_user_type.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_pages/dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  static const route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final repository = AuthRepository();
  var videoPlayerController = VideoPlayerController.asset(
    "assets/videos/tezal_splash_animation.mp4",
  );

  void initializeState() async {
    final _authRepository = AuthRepository();
    AppUserType? userType;

    final userId = await repository.userId;
    print("userId = $userId\n");

    final userToken = await repository.userToken;
    print("userToken = $userToken\n");

    final value = await _authRepository.userType;
    if (value != null && value.isNotEmpty) {
      userType = AppUserTypeParser.fromString(value);
    }

    late String navigationDestination;

    switch (userType) {
      case AppUserType.Customer:
        navigationDestination = DashBoardPage.route;
        break;
      case AppUserType.Market:
        // navigationDestination = DashBoardPage.route;
        break;
      case AppUserType.Delivery:
        // navigationDestination = DashBoardPage.route;
        break;
      default:
        navigationDestination = EncourageLoginPage.route;
    }

    Routes.sailor.navigate(
      navigationDestination,
      navigationType: NavigationType.pushReplace,
    );
  }

  @override
  void initState() {
    super.initState();
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
