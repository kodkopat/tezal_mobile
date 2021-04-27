// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/profile_notifier.dart';
import 'widgets/modal_image_picker.dart';

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
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
                              var map = result as Map<String, dynamic>;
                              setState(() {
                                imagePath = map["imagePath"];
                              });
                            }
                          }),
                        style: ParentStyle()
                          ..width(96)
                          ..height(96)
                          ..borderRadius(all: 48)
                          ..alignmentContent.center()
                          ..ripple(true),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          child: imagePath == null
                              ? Image.asset(
                                  "assets/images/img_profile_placeholder.png",
                                  fit: BoxFit.contain,
                                  width: 96,
                                  height: 96,
                                )
                              : Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.contain,
                                  width: 96,
                                  height: 96,
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: nameCtrl
                          ..text = provider.customerProfile!.data!.name,
                        validator: AppValidators.name,
                        label: "نام کاربری",
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        controller: emailCtrl
                          ..text = provider.customerProfile!.data!.email,
                        validator: AppValidators.email,
                        label: "آدرس ایمیل",
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      ActionBtn(
                        text: "ثبت",
                        onTap: () async {
                          if ((formKey.currentState as FormState).validate()) {
                            prgDialog!.show();

                            String photo = "";
                            if (imagePath != null) {
                              var imgFile = File(imagePath!);
                              var imgBytes = imgFile.readAsBytesSync();
                              photo = base64Encode(imgBytes);
                            }

                            await provider.editInfo(
                              name: nameCtrl.text,
                              email: emailCtrl.text,
                              photo: photo,
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
