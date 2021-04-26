// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/custom_rating_bar.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../data/models/customer/order_detail_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/order_detail_notifier.dart';
import '../order_detail/widgets/order_list_item.dart';

class ProductCommentPage extends StatelessWidget {
  static const route = "customer_product_comment";

  ProductCommentPage({
    required this.orderItem,
    required this.orderDetailNotifier,
  });

  final OrderItem orderItem;
  final OrderDetailNotifier orderDetailNotifier;

  @override
  Widget build(BuildContext context) {
    var ratingBarTxtCtrl = TextEditingController();
    var commentBoxTxtCtrl = TextEditingController();

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "بازخورد محصول",
        showBackBtn: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            Parent(
              style: ParentStyle()
                ..margin(vertical: 8)
                ..padding(horizontal: 16, top: 8)
                ..background.color(Colors.white)
                ..borderRadius(all: 8)
                ..boxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4.0),
                  blur: 8,
                  spread: 0,
                ),
              child: OrderListItem(
                orderItem: orderItem,
                orderDetailNotifier: orderDetailNotifier,
                showCommentOption: false,
              ),
            ),
            Parent(
              style: ParentStyle()
                ..margin(vertical: 16)
                ..padding(horizontal: 16, top: 8)
                ..background.color(Colors.white)
                ..borderRadius(all: 8)
                ..boxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4.0),
                  blur: 8,
                  spread: 0,
                ),
              child: Column(
                children: [
                  CustomRatingBar(
                    labelText: "امتیاز محصول",
                    textCtrl: ratingBarTxtCtrl,
                  ),
                  SizedBox(height: 4),
                  CustomTextInput(
                    label: "نظر کاربر",
                    controller: commentBoxTxtCtrl,
                    validator: AppValidators.comment,
                    keyboardType: TextInputType.text,
                    textDirection: TextDirection.rtl,
                    maxLine: 3,
                  ),
                  SizedBox(height: 16),
                  ActionBtn(
                    text: "ثبت بازخورد",
                    onTap: () {},
                    background: AppTheme.customerPrimary,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
