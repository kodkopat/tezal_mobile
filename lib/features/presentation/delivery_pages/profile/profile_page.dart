// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../base_pages/login/login_page.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  static const route = "/delivery_profile";

  @override
  Widget build(BuildContext context) {
    var authRepo = AuthRepository();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).profilePage,
      ),
      body: CustomFutureBuilder<String?>(
        future: authRepo.userToken,
        successBuilder: (context, data) {
          print("userToken= $data\n");
          if (data == null || data.isEmpty) {
            return _profileEmptyState();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileMenu(),
                ],
              ),
            );
          }
        },
        errorBuilder: (context, error) {
          return AppLoading();
        },
      ),
    );
  }

  Widget _profileEmptyState() {
    return Padding(
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
          Txt(
            "برای دسترسی به اطلاعات حساب کاربری،\n"
            " ابتدا وارد شوید",
            style: AppTxtStyles().footNote..alignment.center(),
          ),
          SizedBox(height: 16),
          ActionBtn(
            text: "ورود به حساب کاربری",
            onTap: () async {
              Routes.sailor(LoginPage.route);
            },
          ),
        ],
      ),
    );
  }
}
