import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../confirm_reset_password/confirm_reset_password.dart';

class ResetPasswordPage extends StatefulWidget {
  static const route = "/reset_password";

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog prgDialog;

  var textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 0.5,
    fontFamily: 'Yekan',
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  @override
  void initState() {
    super.initState();
    prgDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
    )..style(
        message: "لطفا کمی صبر کنید",
        textAlign: TextAlign.start,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: SimpleAppBar().create(
        context,
        text: "درخواست تغییر رمز عبور",
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextInput(
                        controller: phoneCtrl,
                        validator: AppValidators.phone,
                        label: "شماره موبایل",
                        maxLength: 11,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      ActionBtn(
                        text: "ثبت درخواست",
                        onTap: onSubmitBtnTap,
                        background: AppTheme.customerPrimary,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: errorVisibility,
                        child: Txt(
                          errorTxt,
                          style: AppTxtStyles().footNote.clone()
                            ..textColor(Theme.of(context).errorColor)
                            ..alignmentContent.center()
                            ..height(24)
                            ..borderRadius(all: 2)
                            ..padding(horizontal: 4)
                            ..ripple(true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmitBtnTap() async {
    if (formKey.currentState.validate()) {
      prgDialog.show();
      var result = await repository.requestRestPass(
        phone: phoneCtrl.text,
      );

      result.fold(
        (l) {
          prgDialog.hide();

          formKey.currentState.reset();
          setState(() {
            errorTxt = l.message;
            errorVisibility = true;
          });
        },
        (r) {
          prgDialog.hide();
          Routes.sailor.navigate(
            ConfirmResetPasswordPage.route,
            params: {"phone": phoneCtrl.text},
          );
        },
      );
    }
  }
}