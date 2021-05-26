// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/market/product_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/products_notifier.dart';
import '../../market_providers/sub_category_notifier.dart';

class AddProductPage extends StatefulWidget {
  static const route = "/market_add_product";

  AddProductPage({
    required this.product,
    required this.isProductExist,
  });

  final ProductResultModel product;
  final bool isProductExist;

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey formKey = GlobalKey<FormState>();

  late TextEditingController amountCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController discountCtrl;
  late TextEditingController descriptionCtrl;

  late List<String> readyOnSailValues;
  late String readyOnSailDefaultValue;

  String errorTxt = "";
  bool errorVisibility = false;

  late String appBarTxt;

  @override
  void initState() {
    super.initState();

    amountCtrl = TextEditingController(
      text: "${widget.product.step ?? 1}",
    );
    priceCtrl = TextEditingController(
      text: "${widget.product.originalPrice ?? 0}",
    );
    discountCtrl = TextEditingController(
      text: "${widget.product.discountedPrice ?? 0}",
    );
    descriptionCtrl = TextEditingController(
      text: "${widget.product.description ?? ""}",
    );

    readyOnSailValues = ["آماده برای فروش", "برای تامین انبار"];
    if (widget.product.onSale) {
      readyOnSailDefaultValue = readyOnSailValues.first;
    } else {
      readyOnSailDefaultValue = readyOnSailValues.last;
    }

    if (widget.isProductExist) {
      appBarTxt = "ویرایش محصول";
    } else {
      appBarTxt = "افزودن محصول";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: appBarTxt,
        showBackBtn: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextInput(
                      controller: amountCtrl,
                      validator: AppValidators.numeric,
                      label: "تعداد",
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CustomDropDown(
                      label: "آماده برای فروش",
                      defaultValue: readyOnSailDefaultValue,
                      values: readyOnSailValues,
                      onChange: (value) {
                        setState(() {
                          readyOnSailDefaultValue = value;
                        });
                      },
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
                      controller: priceCtrl,
                      validator: AppValidators.description,
                      label: "قیمت محصول",
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: CustomTextInput(
                      controller: discountCtrl,
                      validator: AppValidators.description,
                      label: "تخفیف محصول",
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                controller: descriptionCtrl,
                validator: AppValidators.description,
                label: "توضیحات",
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

                    await productsNotifier.addToMarketProducts(
                      context,
                      productId: widget.product.id,
                      amount: double.parse(amountCtrl.text),
                      discountRate: (double.parse(discountCtrl.text) * 100) /
                          double.parse(priceCtrl.text),
                      discountedPrice: double.parse(discountCtrl.text),
                      originalPrice: double.parse(priceCtrl.text),
                      onSale:
                          readyOnSailDefaultValue == readyOnSailValues.first,
                      description: descriptionCtrl.text,
                    );

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
              if (widget.isProductExist) const SizedBox(height: 8),
              if (widget.isProductExist)
                ActionBtn(
                  text: "حذف محصول",
                  onTap: () async {
                    var productsNotifier = Provider.of<ProductsNotifier>(
                      context,
                      listen: false,
                    );

                    await productsNotifier.removeFromMarketProducts(
                      context,
                      productId: widget.product.id,
                    );

                    var subCategoryNotifier = Get.find<SubCategoryNotifier>();
                    subCategoryNotifier.refreshProducts();
                    Routes.sailor.pop();
                  },
                  background: Colors.red,
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
