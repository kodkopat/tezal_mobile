// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../customer_widgets/simple_app_bar.dart';

class AddProductPage extends StatefulWidget {
  static const route = "/market_add_product";

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey formKey = GlobalKey<FormState>();

  var amountCtrl = TextEditingController();
  var priceCtrl = TextEditingController();
  var discountCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "افزودن محصول",
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              const SizedBox(height: 24),
              CustomTextInput(
                controller: amountCtrl,
                validator: AppValidators.numeric,
                label: "تعداد",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: priceCtrl,
                validator: AppValidators.description,
                label: "قیمت محصول",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: discountCtrl,
                validator: AppValidators.description,
                label: "تخفیف محصول",
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: descriptionCtrl,
                validator: AppValidators.description,
                label: "آماده برای فروش",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: descriptionCtrl,
                validator: AppValidators.description,
                label: "توضیحات",
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              ActionBtn(
                text: "ثبت",
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    var prgDialog = AppProgressDialog(context).instance;
                    prgDialog.show();
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
