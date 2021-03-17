import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../data/repositories/auth_repository.dart';
import '../controllers/registration_validators.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final repository = AuthRepository();

  final formKey = GlobalKey<FormState>();

  var phoneCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  bool contractSigned = false;

  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog prgDialog;

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
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            Txt(
              "ثبت‌نام",
              style: AppTxtStyles().body..textAlign.right(),
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              label: "نام کاربری",
              controller: nameCtrl,
              validator: RegistrationValidators.name,
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              label: "شماره تماس",
              controller: phoneCtrl,
              validator: RegistrationValidators.phone,
              keyboardType: TextInputType.number,
              maxLength: 11,
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              label: "رمز عبور",
              controller: passCtrl,
              validator: RegistrationValidators.pass,
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                    value: contractSigned,
                    onChanged: (value) {
                      setState(() => contractSigned = value);
                    }),
                Txt(
                  "تمامی قراردادهای قانونی را قبول میکنم",
                  style: AppTxtStyles().body..textAlign.right(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: errorVisibility,
              child: Txt(
                errorTxt,
                style: AppTxtStyles().body
                  ..margin(vertical: 4)
                  ..textAlign.right(),
              ),
            ),
            const SizedBox(height: 4),
            ActionBtn(
              text: "ثبت‌نام",
              onTap: onSubmitBtnTap,
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitBtnTap() async {
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

          var storage = FlutterSecureStorage();
          storage.write(key: 'userid', value: r);

          // Routes.sailor(ConfirmRegistrationPage.route);
        },
      );
    }
  }
}
