// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/market/market_profile_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/profile_notifier.dart';

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
  var shabaCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).editProfilePage,
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              CustomTextInput(
                controller: nameCtrl..text = widget.marketProfile.data!.name,
                validator: AppValidators.name,
                label: Lang.of(context).marketProfileName,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: mobileCtrl..text = widget.marketProfile.data!.phone,
                validator: AppValidators.phone,
                label: Lang.of(context).marketProfileMobile,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: phoneCtrl
                  ..text = widget.marketProfile.data!.telephone,
                validator: (value) => null,
                label: Lang.of(context).marketProfileTelephone,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: emailCtrl..text = widget.marketProfile.data!.email,
                validator: (value) => null,
                label: Lang.of(context).marketProfileEmail,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: addressCtrl
                  ..text = widget.marketProfile.data!.address,
                validator: AppValidators.address,
                label: Lang.of(context).marketProfileAddress,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
                maxLine: 2,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: shabaCtrl
                  ..text = widget.marketProfile.data!.shabaNumber,
                validator: AppValidators.shaba,
                label: Lang.of(context).marketProfileShabaNumber,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ActionBtn(
                text: Lang.of(context).edit,
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    var profileInfo = widget.marketProfile.data!;
                    var profileNotifier = Provider.of<MarketProfileNotifier>(
                        context,
                        listen: false);

                    await profileNotifier.updateInfo(
                      context,
                      id: profileInfo.id,
                      name: nameCtrl.text,
                      phone: mobileCtrl.text,
                      telephone: phoneCtrl.text,
                      email: emailCtrl.text,
                      address: addressCtrl.text,
                      shabaNumber: shabaCtrl.text,
                      isOpen: true,
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
