import 'dart:async';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailor/sailor.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';

class ConfirmRegistrationPage extends StatefulWidget {
  static const route = "/confirm_registration";

  @override
  _ConfirmRegistrationPageState createState() =>
      _ConfirmRegistrationPageState();
}

class _ConfirmRegistrationPageState extends State<ConfirmRegistrationPage> {
  final repository = AuthRepository();
  String smsCode;

  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog prgDialog;

  Timer timer;
  int timerSeconds;

  void startTimer() {
    timerSeconds = 60;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer _timer) {
        setState(() {
          if (timerSeconds < 1) {
            _timer.cancel();
          } else {
            timerSeconds--;
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
      appBar: SimpleAppBar(context).create(
        text: "ایجاد حساب کاربری",
        showBackBtn: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Txt(
                      "کد وارد شده به شماره موبایل خود را وارد کنید:",
                      style: AppTxtStyles().body
                        ..alignment.center()
                        ..textAlign.right(),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: PinCodeTextField(
                        autofocus: true,
                        maxLength: 4,
                        onDone: (value) {
                          setState(() => smsCode = value);
                        },
                        pinBoxWidth: 56,
                        pinBoxHeight: 56,
                        pinBoxRadius: 16,
                        pinBoxBorderWidth: 1,
                        pinBoxOuterPadding: EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 0,
                        ),
                        pinBoxColor: Colors.transparent,
                        pinBoxDecoration: (
                          borderColor,
                          pinBoxColor, {
                          borderWidth,
                          radius,
                        }) {
                          return BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          );
                        },
                        keyboardType: TextInputType.number,
                        pinTextStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 256,
                      child: Txt(
                        "ارسال مجدد کد تا " + "$timerSeconds" + " ثانیه دیگر",
                        style: AppTxtStyles().footNote,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: errorVisibility,
                      child: Txt(
                        errorTxt,
                        style: AppTxtStyles().body
                          ..margin(vertical: 4)
                          ..textAlign.right(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ActionBtn(
                      text: "تایید",
                      onTap: onSubmitBtnTap,
                      background: AppTheme.customerPrimary,
                      textColor: Colors.white,
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
          ],
        ),
      ),
    );
  }

  void onSubmitBtnTap() async {
    print("onTap\n");
    var result = await repository.checkUserSms(sms: smsCode);

    result.fold((l) {
      setState(() {
        errorTxt = l.message;
        errorVisibility = true;
      });
    }, (r) {
      // App.restart(context);
      timer.cancel();
      Routes.sailor.pop();
      Routes.sailor.navigate(
        "/",
        navigationType: NavigationType.pushReplace,
      );
    });
  }
}
