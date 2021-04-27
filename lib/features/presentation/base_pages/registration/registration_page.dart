// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../base_widgets/agreement_text.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../confirm_registration/confirm_registration.dart';
import '../login/login_page.dart';

class RegistrationPage extends StatefulWidget {
  static const route = "/registration";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog? prgDialog;

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
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(context).create(
        text: "ایجاد حساب کاربری",
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
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: nameCtrl,
                        validator: AppValidators.name,
                        label: "نام و نام‌ خانوادگی",
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: passCtrl,
                        validator: AppValidators.pass,
                        label: "رمز عبور",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      ActionBtn(
                        text: "ایجاد حساب کاربری",
                        onTap: onRegisterBtnTap,
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
              AgreementText(),
            ],
          ),
        ),
      ),
    );
  }

  void onRegisterBtnTap() async {
    if ((formKey.currentState as FormState).validate()) {
      prgDialog!.show();
      var result = await repository.userRegister(
        name: nameCtrl.text,
        phone: phoneCtrl.text,
        pass: passCtrl.text,
      );

      result.fold(
        (l) {
          prgDialog!.hide();

          (formKey.currentState as FormState).reset();
          setState(() {
            errorTxt = l.message;
            errorVisibility = true;
          });
        },
        (r) {
          prgDialog!.hide();

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
