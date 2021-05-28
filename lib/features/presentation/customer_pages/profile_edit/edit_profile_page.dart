// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/modal_image_picker.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../customer_providers/profile_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/customer_edit_profile";

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  String? imagePath;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProfileNotifier>(
      builder: (context, provider, child) {
        if (provider.customerProfile == null) {
          provider.fetchInfo();
        }

        return provider.customerProfile == null
            ? provider.errorMsg == null
                ? Txt("خطای بارگذاری اطلاعات",
                    style: AppTxtStyles().body..alignment.center())
                : Txt(provider.errorMsg,
                    style: AppTxtStyles().body..alignment.center())
            : Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      Parent(
                        gesture: Gestures()
                          ..onTap(() async {
                            var result = await showModalBottomSheet(
                              context: context,
                              elevation: 16,
                              isDismissible: true,
                              barrierColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              builder: (context) => ImagePickerModal(),
                            );

                            if (result != null) {
                              setState(() {
                                imagePath = result as String;
                              });
                            }
                          }),
                        style: ParentStyle()
                          ..width(96)
                          ..height(96)
                          ..borderRadius(all: 8)
                          ..alignmentContent.center()
                          ..ripple(true),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: imagePath == null
                              ? Image.asset(
                                  "assets/images/img_profile_placeholder.png",
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: nameCtrl
                          ..text = provider.customerProfile!.data!.name,
                        validator: AppValidators.name,
                        label: "نام کاربری",
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: emailCtrl
                          ..text = provider.customerProfile!.data!.email,
                        validator: AppValidators.email,
                        label: "آدرس ایمیل",
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      ActionBtn(
                        text: "ثبت",
                        onTap: () async {
                          if ((formKey.currentState as FormState).validate()) {
                            if (imagePath != null) {
                              var prgDialog =
                                  AppProgressDialog(context).instance;
                              prgDialog.show();

                              var imgFile = File(imagePath!);

                              await provider.editInfo(
                                name: nameCtrl.text,
                                email: emailCtrl.text,
                                photo: imgFile,
                              );

                              prgDialog.hide();

                              Routes.sailor.pop();
                            }
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
              );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "ویرایش اطلاعات کاربری",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
