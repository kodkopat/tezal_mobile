import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailor/sailor.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../../core/widgets/custom_text_input.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../customer_widgets/simple_app_bar.dart';
import 'modal_registration.dart';

class LoginModal extends StatefulWidget {
  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();

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
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: passCtrl,
                        validator: AppValidators.pass,
                        label: "رمز عبور",
                        maxLength: 4,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 24),
                      ActionBtn(
                        text: "ورود به حساب کاربری",
                        onTap: onLoginBtnTap,
                        background: AppTheme.customerPrimary,
                        textColor: Colors.white,
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
              RichText(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "با ورود و یا ثبت‌نام در اپلیکیشن تزآل، شما",
                      style: textStyle,
                    ),
                    TextSpan(
                      text: " شرایط و قوانین ",
                      style:
                          textStyle.copyWith(color: AppTheme.customerPrimary),
                    ),
                    TextSpan(
                      text: "استفاده از سرویس‌های تزآل و",
                      style: textStyle,
                    ),
                    TextSpan(
                      text: " حریم خصوصی ",
                      style:
                          textStyle.copyWith(color: AppTheme.customerPrimary),
                    ),
                    TextSpan(
                      text: "آن را می‌پذیرید.",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onLoginBtnTap() async {
    if (formKey.currentState.validate()) {
      prgDialog.show();
      var result = await repository.userLogin(
        username: phoneCtrl.text,
        password: passCtrl.text,
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

          // App.restart(context);
          Routes.sailor.pop();
          Routes.sailor.navigate(
            "/",
            navigationType: NavigationType.pushReplace,
          );
        },
      );
    }
  }

  void onForgetPassBtnTap() {
    // forget password
  }

  void onRegistrationBtnTap() {
    Routes.sailor.pop();
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => RegistrationModal(),
    );
  }
}
