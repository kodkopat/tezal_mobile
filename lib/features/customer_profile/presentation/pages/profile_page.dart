import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/presentation/widgets/modal_login.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final repository = AuthRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "حساب کاربری"),
        body: CustomFutureBuilder(
          future: repository.userToken,
          successBuilder: (context, data) {
            if (data == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ActionBtn(
                    text: "ورود / ثبت‌نام",
                    onTap: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (context) {
                          return LoginModal();
                        },
                      );
                    },
                    background: AppTheme.customerPrimary,
                    textColor: Colors.white,
                  ),
                ),
              );
            } else {
              return ProfileMenu();
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
