// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/market/market_profile_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/profile_notifier.dart';

class EditProfilePage extends StatefulWidget {
  static const route = "/market_edit_profile";

  EditProfilePage({required this.marketProfile});

  final MarketProfileResultModel marketProfile;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  GlobalKey formKey = GlobalKey<FormState>();

  var nameCtrl = TextEditingController();
  var mobileCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var addressCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "ویرایش اطلاعات",
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              const SizedBox(height: 16),
              CustomTextInput(
                controller: nameCtrl..text = widget.marketProfile.data!.name,
                validator: AppValidators.name,
                label: "نام فروشگاه",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: mobileCtrl..text = widget.marketProfile.data!.phone,
                validator: AppValidators.phone,
                label: "شماره موبایل",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: phoneCtrl
                  ..text = widget.marketProfile.data!.telephone,
                validator: (value) => null,
                label: "شماره تماس ثابت",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: emailCtrl..text = widget.marketProfile.data!.email,
                validator: (value) => null,
                label: "ایمیل",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: addressCtrl
                  ..text = widget.marketProfile.data!.address,
                validator: AppValidators.address,
                label: "آدرس",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              ActionBtn(
                text: "ویرایش",
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    var profileInfo = widget.marketProfile.data!;
                    var profileNotifier =
                        Provider.of<ProfileNotifier>(context, listen: false);

                    await profileNotifier.updateInfo(
                      context,
                      id: profileInfo.id,
                      name: nameCtrl.text,
                      phone: mobileCtrl.text,
                      telephone: phoneCtrl.text,
                      email: emailCtrl.text,
                      address: addressCtrl.text,
                    );

                    if (profileNotifier.updateInfoErrorMsg != null) {
                      setState(() {
                        errorTxt = profileNotifier.updateInfoErrorMsg!;
                        errorVisibility = true;
                      });
                    } else {
                      profileNotifier.refreshInfo();
                      Routes.sailor.pop();
                    }
                  }
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
