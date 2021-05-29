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
import '../../base_widgets/agreement_text.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../confirm_registration/confirm_registration.dart';
import '../login/login_page.dart';

class RegistrationPage extends StatelessWidget {
  static const route = "/registration";

  final _formKey = GlobalKey<FormState>();

  final _phoneCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(context).create(text: "ایجاد حساب کاربری"),
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
                        controller: _nameCtrl,
                        validator: AppValidators.name,
                        label: "نام و نام‌ خانوادگی",
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
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
                        text: "ایجاد حساب کاربری",
                        onTap: () => onRegisterBtnTap(context),
                        background: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Txt(
                        "قبلا عضو شده‌ام",
                        gesture: Gestures()..onTap(onLoginBtnTap),
                        style: AppTxtStyles().footNote.clone()
                          ..alignmentContent.center()
                          ..height(24)
                          ..borderRadius(all: 2)
                          ..padding(horizontal: 4)
                          ..ripple(true),
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

  void onRegisterBtnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await Get.find<AuthRepository>().register(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        pass: _passCtrl.text,
      );

      result.fold(
        (left) {
          prgDialog.hide();

          (_formKey.currentState as FormState).reset();

          ScaffoldMessenger.of(context).showSnackBar(
            GlobalSnackBar(text: left.message),
          );
        },
        (right) {
          prgDialog.hide();

          Routes.sailor(ConfirmRegistrationPage.route);
        },
      );
    }
  }

  void onLoginBtnTap() {
    Routes.sailor.navigate(
      LoginPage.route,
      navigationType: NavigationType.pushReplace,
    );
  }
}
