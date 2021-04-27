// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_avoider/keyboard_avoider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';

class ConfirmResetPasswordPage extends StatefulWidget {
  static const route = "/confirm_reset_password";

  const ConfirmResetPasswordPage({required this.phone});

  final String phone;

  @override
  _ConfirmResetPasswordPageState createState() =>
      _ConfirmResetPasswordPageState();
}

class _ConfirmResetPasswordPageState extends State<ConfirmResetPasswordPage> {
  final repository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  var phoneCtrl;
  final pinCodeCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final newPassRepeatCtrl = TextEditingController();

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

    phoneCtrl = TextEditingController(text: widget.phone);

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
        text: "تغییر رمز عبور",
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: KeyboardAvoider(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: true,
                          child: CustomTextInput(
                            controller: phoneCtrl,
                            validator: AppValidators.phone,
                            label: "شماره موبایل",
                            maxLength: 11,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextInput(
                          controller: pinCodeCtrl,
                          validator: AppValidators.pass,
                          label: "کد تایید یکبار مصرف",
                          maxLength: 4,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 8),
                        CustomTextInput(
                          controller: newPassCtrl,
                          validator: AppValidators.pass,
                          label: "رمز عبور جدید",
                          maxLength: 4,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                        CustomTextInput(
                          controller: newPassRepeatCtrl,
                          validator: AppValidators.pass,
                          label: "تکرار رمز جدید",
                          maxLength: 4,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        ActionBtn(
                          text: "ثبت",
                          onTap: onSubmitBtnTap,
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
                        const SizedBox(height: 16),
                      ],
                    ),
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
    if (((formKey.currentState as FormState)).validate()) {
      prgDialog!.show();
      var result = await repository.resetPass(
        phone: phoneCtrl.text,
        sms: pinCodeCtrl.text,
        password: newPassCtrl.text,
        passwordRepeat: newPassRepeatCtrl.text,
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
          Routes.sailor.pop();
          Routes.sailor.pop();
        },
      );
    }
  }
}
