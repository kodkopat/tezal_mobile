import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/validators/validators.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../../core/widgets/custom_text_input.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../customer_widgets/simple_app_bar.dart';
import 'modal_confirm_registration.dart';
import 'modal_login.dart';

class RegistrationModal extends StatefulWidget {
  @override
  _RegistrationModalState createState() => _RegistrationModalState();
}

class _RegistrationModalState extends State<RegistrationModal> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
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
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: nameCtrl,
                        validator: AppValidators.name,
                        label: "نام کاربری",
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
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
                        text: "ایجاد حساب کاربری",
                        onTap: onRegisterBtnTap,
                        background: AppTheme.customerPrimary,
                        textColor: Colors.white,
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

  void onRegisterBtnTap() async {
    if (formKey.currentState.validate()) {
      prgDialog.show();
      var result = await repository.userRegister(
        name: nameCtrl.text,
        phone: phoneCtrl.text,
        pass: passCtrl.text,
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
          showDialog(
            context: context,
            useSafeArea: true,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.2),
            builder: (context) => ConfirmRegistrationModal(),
          );
        },
      );
    }
  }

  void onLoginBtnTap() {
    Routes.sailor.pop();
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) => LoginModal(),
    );
  }
}
