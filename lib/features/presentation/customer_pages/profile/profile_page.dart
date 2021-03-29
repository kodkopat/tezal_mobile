import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/customer_profile_result_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/customer_repository.dart';
import 'widgets/modal_login.dart';
import 'widgets/profile_info_box.dart';
import 'widgets/profile_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final customerRepo = CustomerRepository();
  final authRepo = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "حساب کاربری"),
        body: CustomFutureBuilder(
          future: authRepo.userToken,
          successBuilder: (context, data) {
            print("userToken= $data\n");
            if (data == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ActionBtn(
                    text: "ورود / ثبت‌نام",
                    onTap: () async {
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
              return Column(
                children: [
                  CustomFutureBuilder<
                      Either<Failure, CustomerProfileResultModel>>(
                    future: customerRepo.customerProfile(),
                    successBuilder: (context, data) {
                      return data.fold(
                        (l) => Txt(
                          "${l.message}",
                          style: AppTxtStyles().body,
                        ),
                        (r) => ProfileInfoBox(profileInfo: r),
                      );
                    },
                    errorBuilder: (context, error) {
                      return AppLoading(color: AppTheme.customerPrimary);
                    },
                  ),
                  Expanded(
                    child: ProfileMenu(),
                  ),
                ],
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
