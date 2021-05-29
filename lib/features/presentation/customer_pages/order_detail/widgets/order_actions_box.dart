// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../data/models/customer/order_detail_result_model.dart';
import '../../../customer_providers/basket_notifier.dart';
import '../../../customer_providers/order_detail_notifier.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../market_comment/market_comment_page.dart';

class OrderActionsBox extends StatelessWidget {
  OrderActionsBox({
    required this.orderDetail,
    required this.orderDetailNotifier,
  });

  final OrderDetailResultModel orderDetail;
  final OrderDetailNotifier orderDetailNotifier;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..margin(horizontal: 16, vertical: 8)
        ..padding(horizontal: 16, vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Txt(
                        "خرید از فروشگاه ",
                        style: AppTxtStyles().body
                          ..textAlign.right()
                          ..bold(),
                      ),
                      Txt(
                        "${orderDetail.data!.marketName}",
                        style: AppTxtStyles().body,
                      ),
                    ],
                  ),
                  _fieldDeliveryCost,
                ],
              ),
              Parent(
                gesture: Gestures()
                  ..onTap(() {
                    Routes.sailor.navigate(
                      MarketCommentPage.route,
                      params: {
                        "marketName": "${orderDetail.data!.marketName}",
                        "orderId": "${orderDetail.data!.id}",
                      },
                    );
                  }),
                style: ParentStyle()
                  ..width(48)
                  ..height(48)
                  ..borderRadius(all: 24)
                  ..alignmentContent.center()
                  ..ripple(true),
                child: Image.asset(
                  "assets/images/ic_comment.png",
                  fit: BoxFit.contain,
                  color: Colors.black26,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: _fieldTotalPrice,
              ),
              _verticalDivider,
              Expanded(
                flex: 1,
                child: _fieldTotalDiscount,
              ),
              _verticalDivider,
              Expanded(
                flex: 1,
                child: _fieldPaymentType,
              ),
            ],
          ),
          const Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          ActionBtn(
            text: "افزودن به سبد خرید",
            textColor: Colors.white,
            background: AppTheme.customerPrimary,
            height: 42,
            onTap: () async {
              await orderDetailNotifier.addOrderToBasket(
                context: context,
                orderId: orderDetail.data!.id,
              );

              Get.find<BasketNotifier>().refresh();

              Routes.sailor.pop();
              Routes.sailor.pop();
            },
          ),
        ],
      ),
    );
  }

  Widget get _verticalDivider => SizedBox(
        height: 40,
        child: VerticalDivider(
          color: Colors.black12,
          thickness: 0.5,
          width: 0,
        ),
      );

  Widget get _fieldTotalPrice => CustomRichText(
        title: "قیمت محصولات" + "\n",
        text: _generatePriceText(orderDetail.data!.totalPrice),
        textAlign: TextAlign.center,
      );

  Widget get _fieldTotalDiscount => CustomRichText(
        title: "تخفیف محصولات" + "\n",
        text: _generatePriceText(
            orderDetail.data!.totalPrice - orderDetail.data!.totalDiscount),
        textAlign: TextAlign.center,
      );

  Widget get _fieldDeliveryCost => CustomRichText(
        title: "هزینه ارسال",
        text: _generatePriceText(orderDetail.data!.deliveryCost),
      );

  Widget get _fieldPaymentType => CustomRichText(
        title: "شیوه پرداخت" + "\n",
        text: orderDetail.data!.paymentType,
        textAlign: TextAlign.center,
      );

  String _generatePriceText(int? price) {
    var text;
    if (price == null) {
      text = " ذکر نشده ";
    } else if (price == 0) {
      text = " رایگان ";
    } else {
      var temp;
      if ("$price".length >= 3) {
        temp = intl.NumberFormat("#,000").format(price);
      } else {
        temp = "$price";
      }

      text = " $temp " + "تومان";
    }

    return text;
  }
}
