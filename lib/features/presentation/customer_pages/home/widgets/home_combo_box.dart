// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../providers/customer_providers/address_notifier.dart';
import 'home_combo_box_drop_down.dart';

class HomeComboBox extends StatelessWidget {
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
                    provider.listErrorMsg!,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.addressList!.isEmpty
                    ? Txt(
                        "لیست آدرس‌های شما خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : HomeComboBoxDropDown(
                        addresses: provider.addressList!,
                        addressNotifier: provider,
                      );
      },
    );

    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: consumer,
    );
  }
}
