// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/global_snack_bar.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';

class ConfirmResetPasswordPage extends StatelessWidget {
  static const route = "/confirm_reset_password";

  ConfirmResetPasswordPage({required this.phone});

  final String phone;

  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final _phoneCtrl = TextEditingController();
  final _pinCodeCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _newPassRepeatCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(context).create(
        text: "تغییر رمز عبور",
        showBackBtn: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: KeyboardAvoider(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: CustomTextInput(
                          controller: _phoneCtrl..text = phone,
                          validator: AppValidators.phone,
                          label: "شماره موبایل",
                          maxLength: 11,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: _pinCodeCtrl,
                        validator: AppValidators.pass,
                        label: "کد تایید یکبار مصرف",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: _newPassCtrl,
                        validator: AppValidators.pass,
                        label: "رمز عبور جدید",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: _newPassRepeatCtrl,
                        validator: AppValidators.pass,
                        label: "تکرار رمز جدید",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      ActionBtn(
                        text: "ثبت",
                        onTap: () => onSubmitBtnTap(context),
                        background: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitBtnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await Get.find<AuthRepository>().resetPassword(
        phone: _phoneCtrl.text,
        sms: _pinCodeCtrl.text,
        password: _newPassCtrl.text,
        passwordRepeat: _newPassRepeatCtrl.text,
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
          Routes.sailor.pop();
          Routes.sailor.pop();
        },
      );
    }
  }
}
