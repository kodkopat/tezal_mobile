// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/products_notifier.dart';

class AddProductDraftPage extends StatefulWidget {
  static const route = "/market_add_product_draft";

  AddProductDraftPage({
    required this.mainCategoryId,
    required this.mainCategoryName,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  final String mainCategoryId;
  final String mainCategoryName;
  final String subCategoryId;
  final String subCategoryName;

  @override
  _AddProductDraftPageState createState() => _AddProductDraftPageState();
}

class _AddProductDraftPageState extends State<AddProductDraftPage> {
  GlobalKey formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController mainCategoryCtrl;
  late TextEditingController subCategoryCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController discountCtrl;
  late TextEditingController descriptionCtrl;

  String errorTxt = "";
  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController();
    mainCategoryCtrl = TextEditingController(
      text: widget.mainCategoryName,
    );
    subCategoryCtrl = TextEditingController(
      text: widget.subCategoryName,
    );
    priceCtrl = TextEditingController();
    discountCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
  }

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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              CustomTextInput(
                label: "نام محصول",
                controller: nameCtrl,
                validator: AppValidators.name,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AbsorbPointer(
                      absorbing: true,
                      child: CustomTextInput(
                        label: "دسته‌بندی اصلی",
                        controller: mainCategoryCtrl,
                        validator: (value) => null,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: AbsorbPointer(
                      absorbing: true,
                      child: CustomTextInput(
                        label: "دسته‌بندی فرعی",
                        controller: subCategoryCtrl,
                        validator: (value) => null,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextInput(
                      label: "قیمت محصول",
                      controller: priceCtrl,
                      validator: AppValidators.description,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CustomTextInput(
                      label: "تخفیف محصول",
                      controller: discountCtrl,
                      validator: AppValidators.description,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                label: "توضیحات",
                controller: descriptionCtrl,
                validator: AppValidators.description,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
                maxLine: 4,
              ),
              const SizedBox(height: 16),
              ActionBtn(
                text: "ثبت",
                onTap: () async {
                  if ((formKey.currentState as FormState).validate()) {
                    var productsNotifier =
                        Provider.of<ProductsNotifier>(context, listen: false);

                    // await productsNotifier.addToMarketProducts(
                    //   context,
                    //   productId: widget.product.id,
                    //   amount: double.parse(amountCtrl.text),
                    //   discountRate: (double.parse(discountCtrl.text) * 100) /
                    //       double.parse(priceCtrl.text),
                    //   discountedPrice: double.parse(discountCtrl.text),
                    //   originalPrice: double.parse(priceCtrl.text),
                    //   onSale:
                    //       readyOnSailDefaultValue == readyOnSailValues.first,
                    //   description: descriptionCtrl.text,
                    // );

                    if (productsNotifier.addToMarketProductsErrorMsg != null) {
                      setState(() {
                        errorTxt =
                            productsNotifier.addToMarketProductsErrorMsg!;
                        errorVisibility = true;
                      });
                    } else {
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
