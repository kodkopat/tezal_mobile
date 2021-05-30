// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_rating_bar.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/global_snack_bar.dart';
import '../../../data/models/customer/order_detail_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_providers/product_comments_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../order_detail/widgets/order_list_item.dart';

class ProductCommentPage extends StatelessWidget {
  static const route = "customer_product_comment";

  ProductCommentPage({
    required this.orderId,
    required this.orderItem,
  });

  final String orderId;
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var ratingBarTxtCtrl = TextEditingController(text: "50");
    var commentBoxTxtCtrl = TextEditingController();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "بازخورد محصول",
        showBackBtn: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProductCommentsNotifier(
          Get.find<CustomerProductRepository>(),
        ),
        child: Consumer<ProductCommentsNotifier>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..margin(vertical: 8)
                      ..padding(horizontal: 16, top: 8)
                      ..background.color(Colors.white)
                      ..borderRadius(all: 8)
                      ..boxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3.0),
                        blur: 6,
                        spread: 0,
                      ),
                    child: OrderListItem(
                      orderItem: orderItem,
                      showCommentOption: false,
                      onCommentTap: () {},
                    ),
                  ),
                  Parent(
                    style: ParentStyle()
                      ..margin(vertical: 16)
                      ..padding(horizontal: 16, top: 8)
                      ..background.color(Colors.white)
                      ..borderRadius(all: 8)
                      ..boxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3.0),
                        blur: 6,
                        spread: 0,
                      ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomRatingBar(
                            labelText: "امتیاز محصول",
                            textCtrl: ratingBarTxtCtrl,
                          ),
                          const SizedBox(height: 4),
                          CustomTextInput(
                            label: "نظر کاربر",
                            controller: commentBoxTxtCtrl,
                            validator: AppValidators.comment,
                            keyboardType: TextInputType.text,
                            textDirection: TextDirection.rtl,
                            maxLine: 3,
                          ),
                          const SizedBox(height: 16),
                          ActionBtn(
                            text: "ثبت بازخورد",
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await provider.addEditCommentRate(
                                  context,
                                  comment: commentBoxTxtCtrl.text,
                                  marketProductId: orderItem.id,
                                  orderId: orderId,
                                  rate: int.parse(ratingBarTxtCtrl.text),
                                );

                                if (provider.addEditCommentRateErrorMsg !=
                                    null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    GlobalSnackBar(
                                      text:
                                          "${provider.addEditCommentRateErrorMsg}",
                                    ),
                                  );
                                } else {
                                  Routes.sailor.pop();
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
