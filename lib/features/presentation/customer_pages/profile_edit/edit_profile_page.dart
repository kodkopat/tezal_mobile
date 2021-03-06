// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/consts/consts.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/modal_image_picker.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../base_widgets/custom_image_network.dart';
import '../../customer_providers/profile_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/customer_edit_profile";

  EditProfilePage({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;

  File? imgFile;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.name);
    emailCtrl = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    var profileNotifier = Get.find<CustomerProfileNotifier>();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "ویرایش اطلاعات کاربری",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: formKey,
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

                    var prgDialog = AppProgressDialog(context).instance;
                    await prgDialog.show();

                    if (result != null) {
                      var imagePath = result as String;
                      imgFile = File(imagePath);

                      await prgDialog.hide();

                      setState(() {});
                    }
                  }),
                style: ParentStyle()
                  ..width(96)
                  ..height(96)
                  ..borderRadius(all: 8)
                  ..alignmentContent.center()
                  ..background.image(
                    path: "assets/images/img_placeholder.jpg",
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  )
                  ..ripple(true),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: imgFile == null
                      ? CustomImageNetwork(
                          imageUrl: "${customerBaseApiUrl}Customer/getphoto",
                        )
                      : Image.file(
                          imgFile!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: nameCtrl,
                validator: AppValidators.name,
                label: "نام کاربری",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: emailCtrl,
                validator: AppValidators.email,
                label: "آدرس ایمیل",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              ActionBtn(
                text: "ثبت",
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    var prgDialog = AppProgressDialog(context).instance;
                    prgDialog.show();

                    await profileNotifier.editInfo(
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      photo: imgFile,
                    );

                    // clear cached image from memory
                    PaintingBinding.instance!.imageCache!.clear();
                    imageCache!.clear();

                    prgDialog.hide();
                    Routes.sailor.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
