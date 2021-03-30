import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tezal/core/page_routes/routes.dart';
import 'package:tezal/features/data/repositories/customer_repository.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/simple_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/customer_edit_profile";

  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final customerRepo = CustomerRepository();

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

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
      appBar: SimpleAppBar.intance(
        text: "ویرایش اطلاعات کاربری",
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              CustomTextInput(
                controller: nameCtrl,
                validator: AppValidators.name,
                label: "نام کاربری",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              CustomTextInput(
                controller: emailCtrl,
                validator: AppValidators.email,
                label: "آدرس ایمیل",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              ActionBtn(
                text: "ثبت",
                onTap: onSubmitBtn,
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
    );
  }

  void onSubmitBtn() async {
    if (formKey.currentState.validate()) {
      prgDialog.show();

      var result = await customerRepo.editCustomerProfile(
        name: nameCtrl.text,
        email: emailCtrl.text,
      );

      prgDialog.hide();
      result.fold(
        (l) {
          setState(() {
            errorTxt = l.message;
            errorVisibility = true;
          });
        },
        (r) {
          Routes.sailor.pop();
        },
      );
    }
  }
}
