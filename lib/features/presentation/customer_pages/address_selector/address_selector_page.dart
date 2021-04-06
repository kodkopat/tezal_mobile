import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../providers/customer_providers/address_notifier.dart';
import 'widgets/address_selector_list.dart';

class AddressesSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<AddressNotifier>(
      builder: (context, provider, child) {
        if (provider.addressesResultModel == null &&
            provider.listErrorMsg == null) {
          provider.fetchAddresses();
        }

        return provider.listLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.listErrorMsg != null
                ? Txt(
                    provider.listErrorMsg,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.addressList.isEmpty
                    ? Txt(
                        "لیست آدرس‌های شما خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            AddressSelectorList(addressNotifier: provider),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              child: ActionBtn(
                                text: "تایید آدرس پیش‌فرض",
                                onTap: () {
                                  Routes.sailor.pop();
                                },
                                background: AppTheme.customerPrimary,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
      },
    );

    return SafeArea(
      child: Parent(
        style: ParentStyle()
          ..padding(top: 8)
          ..borderRadius(topLeft: 16, topRight: 16)
          ..background.color(Colors.white),
        child: consumer,
        /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            Routes.sailor.navigate(
              AddressSavePage.route,
              params: {},
            );
          },
          child: Icon(
            Feather.plus,
            color: Colors.white,
            size: 24,
          ),
        ), */
      ),
    );
  }
}
