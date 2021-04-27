// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
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
import '../../providers/app_notifier.dart';
import '../registration/registration_page.dart';
import '../reset_password/reset_password_page.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();
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
        text: "ورود به حساب کاربری",
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
                        controller: passCtrl,
                        validator: AppValidators.pass,
                        label: "رمز عبور",
                        maxLength: 4,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      ActionBtn(
                        text: "ورود به حساب کاربری",
                        onTap: onLoginBtnTap,
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

  Future<void> onLoginBtnTap() async {
    if (((formKey.currentState as FormState)).validate()) {
      prgDialog!.show();
      var result = await repository.userLogin(
        username: phoneCtrl.text,
        password: passCtrl.text,
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

          var appNotifier = Provider.of<AppNotifier>(context, listen: false);
          appNotifier.refresh();

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
