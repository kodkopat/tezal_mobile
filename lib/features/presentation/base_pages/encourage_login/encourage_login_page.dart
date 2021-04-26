// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../customer_pages/dashboard/dashboard_page.dart';
import '../login/login_page.dart';

class EncourageLoginPage extends StatelessWidget {
  static const route = "/encourage_login_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Parent(
              style: ParentStyle()
                ..width(80)
                ..alignmentContent.center(),
              child: AspectRatio(
                aspectRatio: 1 / 2,
                child: Image.asset(
                  "assets/images/img_tezal_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ActionBtn(
              text: "ورود به حساب کاربری",
              onTap: () async {
                Routes.sailor.navigate(
                  LoginPage.route,
                  navigationType: NavigationType.pushReplace,
                );
              },
              background: AppTheme.customerPrimary,
              textColor: Colors.white,
            ),
            SizedBox(height: 16),
            ActionBtn(
              text: "ورود به عنوان کاربر میهمان",
              onTap: () async {
                Routes.sailor.navigate(
                  DashBoardPage.route,
                  navigationType: NavigationType.pushReplace,
                );
              },
              background: Color(0xffEFEFEF),
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
