import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../customer_dashboard/presentation/pages/dashboard_page.dart';
import '../../data/repositories/auth_repository.dart';

class SplashPage extends StatefulWidget {
  static const route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final repository = AuthRepository();

  void initializeState() async {
    final _authRepository = AuthRepository();
    _AppUserType userType;

    final value = await _authRepository.userType;
    if (value != null && value.isNotEmpty) {
      userType = _AppUserTypeParser.fromString(value);
    } else {
      userType = _AppUserType.Customer;
    }

    switch (userType) {
      case _AppUserType.Customer:
        Routes.sailor(CustomerDashBoardPage.route);
        break;
      case _AppUserType.Market:
        // Routes.sailor(CustomerDashBoardPage.route);
        break;
      case _AppUserType.Delivery:
        // Routes.sailor(CustomerDashBoardPage.route);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Txt(
          "خوش آمدید",
          style: AppTxtStyles().body,
        ),
      ),
    );
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
    if (userType == null || userType.trim().isEmpty)
      return _AppUserType.Customer;

    switch (userType.toLowerCase()) {
      case _customerKey:
        return _AppUserType.Customer;
        break;
      case _marketKey:
        return _AppUserType.Market;
        break;
      case _deliveryKey:
        return _AppUserType.Delivery;
        break;
      default:
        return _AppUserType.Customer;
        break;
    }
  }
}
