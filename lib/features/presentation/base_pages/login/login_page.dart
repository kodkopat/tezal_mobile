// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/global_snack_bar.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../app_notifier.dart';
import '../../base_widgets/agreement_text.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../registration/registration_page.dart';
import '../reset_password/reset_password_page.dart';

class LoginPage extends StatelessWidget {
  static const route = "/login";

  final _formKey = GlobalKey<FormState>();

  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(context).create(text: "ورود به حساب کاربری"),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextInput(
                        controller: _phoneCtrl,
                        validator: AppValidators.phone,
                        label: "شماره موبایل",
                        maxLength: 11,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: _passCtrl,
                        validator: AppValidators.pass,
                        label: "رمز عبور",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ActionBtn(
                        text: "ورود به حساب کاربری",
                        onTap: () => onLoginBtnTap(context),
                        background: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            "ایجاد حساب کاربری جدید",
                            gesture: Gestures()..onTap(onRegistrationBtnTap),
                            style: AppTxtStyles().footNote.clone()
                              ..alignmentContent.centerRight()
                              ..height(24)
                              ..borderRadius(all: 2)
                              ..padding(horizontal: 4)
                              ..ripple(true),
                          ),
                          Txt(
                            "فراموش کردن رمز عبور",
                            gesture: Gestures()..onTap(onForgetPassBtnTap),
                            style: AppTxtStyles().footNote.clone()
                              ..alignmentContent.centerLeft()
                              ..height(24)
                              ..borderRadius(all: 2)
                              ..padding(horizontal: 4)
                              ..ripple(true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AgreementText(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onLoginBtnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await Get.find<AuthRepository>().login(
        username: _phoneCtrl.text,
        password: _passCtrl.text,
      );

      result.fold(
        (left) {
          prgDialog.hide();

          (_formKey.currentState as FormState).reset();

          FocusScope.of(context).requestFocus(FocusNode());

          ScaffoldMessenger.of(context).showSnackBar(
            GlobalSnackBar(text: left.message),
          );
        },
        (right) {
          prgDialog.hide();

          Get.find<AppNotifier>().refresh();

          Routes.sailor.navigate(
            "/",
            navigationType: NavigationType.pushReplace,
          );
        },
      );
    }
  }

  void onForgetPassBtnTap() async {
    Routes.sailor(ResetPasswordPage.route);
  }

  void onRegistrationBtnTap() {
    Routes.sailor.navigate(
      RegistrationPage.route,
      navigationType: NavigationType.pushReplace,
    );
  }
}
