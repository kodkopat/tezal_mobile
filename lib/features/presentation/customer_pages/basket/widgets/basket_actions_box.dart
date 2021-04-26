// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tezal/core/page_routes/routes.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/action_btn.dart';
import '../../../../data/models/customer/basket_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import '../../../providers/customer_providers/order_notifier.dart';
import '../../address_selector/address_selector_page.dart';
import '../../payment_method_selector/payment_method_selector.dart';
import 'modal_empty_basket.dart';

class BasketActionsBox extends StatelessWidget {
  const BasketActionsBox({
    required this.basket,
    required this.basketNotifier,
  });

  final BasketResultModel basket;
  final BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    final orderNotifier = Provider.of<OrderNotifier>(context, listen: false);

    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..margin(horizontal: 16, vertical: 8)
        ..padding(horizontal: 16, vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        ),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Txt(
                        "خرید از فروشگاه ",
                        style: AppTxtStyles().body
                          ..textAlign.right()
                          ..bold(),
                      ),
                      Txt(
                        "${basket.data!.marketName}",
                        style: AppTxtStyles().body,
                      ),
                    ],
                  ),
                  _fieldDeliveryCost,
                ],
              ),
              Parent(
                gesture: Gestures()
                  ..onTap(() async {
                    showDialog(
                      context: context,
                      useSafeArea: true,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.2),
                      builder: (context) {
                        return EmptyBasketModal(
                          onAccept: () async {
                            await basketNotifier.clearBasket(context);
                            Routes.sailor.pop();
                          },
                          onDiscard: () {
                            Routes.sailor.pop();
                          },
                        );
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
                  "assets/images/ic_delete.png",
                  fit: BoxFit.contain,
                  color: Colors.black26,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: _fieldTotalPrice),
              _verticalDivider,
              Expanded(flex: 1, child: _fieldTotalDiscount),
              _verticalDivider,
              Expanded(flex: 1, child: _fieldPayableCost),
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 24,
          ),
          ActionBtn(
            text: "ادامه فرآیند خرید",
            textColor: Colors.white,
            background: AppTheme.customerPrimary,
            height: 42,
            onTap: () async {
              final returedData = await showModalBottomSheet(
                context: context,
                elevation: 16,
                isDismissible: false,
                isScrollControlled: true,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.75,
                  child: AddressesSelectorPage(),
                ),
              );

              var map = returedData as Map<String, dynamic>;
              if (map["result"]) {
                await showModalBottomSheet(
                  context: context,
                  elevation: 16,
                  isDismissible: false,
                  isScrollControlled: true,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  builder: (context) => FractionallySizedBox(
                    heightFactor: 0.75,
                    child: PaymentMethodSelectorPage(),
                  ),
                );

                basketNotifier.refresh();
                orderNotifier.refresh(context);
              }
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

  Widget get _fieldTotalPrice {
    return CustomRichText(
      title: "قیمت محصولات" + "\n",
      text: _generatePriceText(
        basket.data!.totalPrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldTotalDiscount {
    return CustomRichText(
      title: "تخفیف محصولات" + "\n",
      text: _generatePriceText(
        basket.data!.totalPrice - basket.data!.totalDiscountedPrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldDeliveryCost {
    return CustomRichText(
      title: "هزینه ارسال",
      text: _generatePriceText(
        basket.data!.deliveryCost,
      ),
    );
  }

  Widget get _fieldPayableCost {
    return CustomRichText(
      title: "مبلغ قابل پرداخت" + "\n",
      text: _generatePriceText(
        basket.data!.payablePrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  String _generatePriceText(num price) {
    var text;
    if (price == 0) {
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
