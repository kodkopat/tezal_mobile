// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/profile_notifier.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/customer_edit_profile";

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  var profileNotifier;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  ProgressDialog? prgDialog;

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
    profileNotifier ??= Provider.of<ProfileNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
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
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    prgDialog!.show();

                    await profileNotifier.editInfo(
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                    );

                    prgDialog!.hide();
                    Routes.sailor.pop();
                  }
                },
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
}
