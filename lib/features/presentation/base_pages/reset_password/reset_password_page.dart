// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/global_snack_bar.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../confirm_reset_password/confirm_reset_password.dart';

class ResetPasswordPage extends StatelessWidget {
  static const route = "/reset_password";

  final _formKey = GlobalKey<FormState>();

  final _phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "درخواست تغییر رمز عبور",
        showBackBtn: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
              ActionBtn(
                text: "ثبت درخواست",
                onTap: () => onSubmitBtnTap(context),
                background: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmitBtnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await Get.find<AuthRepository>().resetPasswordRequest(
        phone: _phoneCtrl.text,
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

          Routes.sailor.navigate(
            ConfirmResetPasswordPage.route,
            params: {"phone": _phoneCtrl.text},
          );
        },
      );
    }
  }
}
