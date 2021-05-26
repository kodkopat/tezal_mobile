// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../customer_providers/addresses_notifier.dart';
import '../../customer_providers/order_notifier.dart';

class PaymentMethodSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressNotifier = Provider.of<AddressesNotifier>(
      context,
      listen: false,
    );

    final orderNotifier = Provider.of<OrderNotifier>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Parent(
        style: ParentStyle()
          ..padding(horizontal: 24, top: 8)
          ..borderRadius(topLeft: 16, topRight: 16)
          ..background.color(Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              "انتخاب شیوه پرداخت",
              style: AppTxtStyles().heading..alignment.center(),
            ),
            SizedBox(height: 24),
            ActionBtn(
              text: "پرداخت از کیف پول",
              onTap: () async {
                await orderNotifier.saveOrder(
                  paymentType: 3,
                  addressId: addressNotifier.selectedOrderAddressId!,
                  deliveryTime: "", //TODO: where is deliveryTime?
                );
                Routes.sailor.pop();
              },
              background: AppTheme.customerPrimary,
              textColor: Colors.white,
            ),
            SizedBox(height: 24),
            AbsorbPointer(
              absorbing: true,
              child: ActionBtn(
                text: "پرداخت با دستگاه کارت‌خوان",
                onTap: () {},
                background: Color(0xffEFEFEF),
                textColor: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            AbsorbPointer(
              absorbing: true,
              child: ActionBtn(
                text: "پرداخت از درگاه الکترونیک",
                onTap: () {},
                background: Color(0xffEFEFEF),
                textColor: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
