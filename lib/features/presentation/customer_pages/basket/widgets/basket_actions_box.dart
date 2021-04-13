// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tezal/features/presentation/customer_pages/payment_method_selector/payment_method_selector.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../data/models/basket_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import '../../../providers/customer_providers/order_notifier.dart';
import '../../address_selector/address_selector_page.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Txt(
                "خرید از فروشگاه: ",
                style: AppTxtStyles().body..bold(),
              ),
              Txt(
                "${basket.data.marketName}",
                style: AppTxtStyles().body,
              ),
            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 16,
          ),
          _fieldTotalPrice,
          SizedBox(height: 4),
          _fieldTotalDiscount,
          SizedBox(height: 4),
          _fieldDeliveryCost,
          SizedBox(height: 4),
          _fieldPayableCost,
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 16,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Txt(
                  "ثبت خرید",
                  gesture: Gestures()
                    ..onTap(() async {
                      final returedData = await showModalBottomSheet(
                        context: context,
                        elevation: 16,
                        isDismissible: false,
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.75,
                            child: AddressesSelectorPage(),
                          );
                        },
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
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.75,
                              child: PaymentMethodSelectorPage(),
                            );
                          },
                        );

                        basketNotifier.refresh();
                        orderNotifier.refresh();
                      }
                    }),
                  style: AppTxtStyles().body
                    ..textColor(AppTheme.customerPrimary)
                    ..borderRadius(all: 4)
                    ..background.color(
                      AppTheme.customerPrimary.withOpacity(0.2),
                    )
                    ..padding(vertical: 8)
                    ..ripple(true),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Txt(
                  "خالی کردن سبد",
                  gesture: Gestures()
                    ..onTap(() async {
                      await basketNotifier.clearBasket(context);
                    }),
                  style: AppTxtStyles().body
                    ..textColor(Colors.red)
                    ..borderRadius(all: 4)
                    ..background.color(Colors.red.withOpacity(0.2))
                    ..padding(vertical: 8)
                    ..ripple(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _fieldTotalPrice {
    return CustomRichText(
      title: "قیمت محصولات: ",
      text: _generatePriceText(
        basket.data.totalPrice,
      ),
    );
  }

  Widget get _fieldTotalDiscount {
    return CustomRichText(
      title: "تخفیف محصولات: ",
      text: _generatePriceText(
        basket.data.totalDiscountedPrice,
      ),
    );
  }

  Widget get _fieldDeliveryCost {
    return CustomRichText(
      title: "هزینه ارسال: ",
      text: _generatePriceText(
        basket.data.deliveryCost,
      ),
    );
  }

  Widget get _fieldPayableCost {
    return CustomRichText(
      title: "مبلغ قابل پرداخت: ",
      text: _generatePriceText(
        basket.data.payable,
      ),
    );
  }

  String _generatePriceText(int price) {
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
