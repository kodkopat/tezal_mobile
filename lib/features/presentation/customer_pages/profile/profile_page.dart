import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../base_pages/login/login_page.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/profile_notifier.dart';
import '../profile_edit/edit_profile_page.dart';
import 'widgets/profile_info_box.dart';
import 'widgets/profile_menu.dart';

class ProfilePage extends StatefulWidget {
  static const route = "/customer_profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authRepo = AuthRepository();
  ProfileNotifier profileNotifier;

  @override
  Widget build(BuildContext context) {
    profileNotifier ??= Provider.of<ProfileNotifier>(context, listen: false);

    var consumer = Consumer<ProfileNotifier>(
      builder: (context, provider, child) {
        if (provider.loading && provider.errorMsg == null) {
          provider.fetchInfo();
        }

        return provider.loading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.errorMsg != null
                ? Txt(
                    "${provider.errorMsg}",
                    style: AppTxtStyles().body,
                  )
                : ProfileInfoBox(
                    profileInfo: provider.customerProfile,
                    onEditBtnTap: () {
                      Routes.sailor(EditProfilePage.route);
                    },
                  );
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar(context).create(text: "حساب کاربری"),
        body: CustomFutureBuilder(
          future: authRepo.userToken,
          successBuilder: (context, data) {
            print("userToken= $data\n");
            if (data == null || data.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ActionBtn(
                    text: "ورود / ثبت‌نام",
                    onTap: () async {
                      Routes.sailor(LoginPage.route);
                    },
                    background: AppTheme.customerPrimary,
                    textColor: Colors.white,
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    consumer,
                    ProfileMenu(),
                  ],
                ),
              );
            }
          },
          errorBuilder: (context, error) {
            return AppLoading(color: AppTheme.customerPrimary);
          },
        ),
      ),
    );
  }
}
