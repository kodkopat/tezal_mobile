import 'dart:async';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../data/repositories/auth_repository.dart';

class ConfirmRegistrationPage extends StatefulWidget {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Txt(
            "تایید ثبت‌نام",
            style: AppTxtStyles().body..textAlign.right(),
          ),
          const SizedBox(height: 8),
          Txt(
            "کد وارد شده به شماره موبایل خود را وارد کنید:",
            style: AppTxtStyles().body
              ..alignment.centerRight()
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
            text: timerSeconds < 1 ? "تایید" : "ارسال مجدد",
            onTap: onSubmitBtnTap,
          ),
        ],
      ),
    );
  }

  void onSubmitBtnTap() async {
    var result = await repository.checkUserSms(
      id: null,
      sms: smsCode,
    );

    result.fold((l) {
      setState(() {
        errorTxt = l.message;
        errorVisibility = true;
      });
    }, (r) {
      // Routes.sailor(ConfirmRegistrationPage.route);
    });
  }
}
