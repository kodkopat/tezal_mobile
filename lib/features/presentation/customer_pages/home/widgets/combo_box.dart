// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/loading.dart';
import '../../../customer_providers/addresses_notifier.dart';
import 'combo_box_drop_down.dart';

class HomeComboBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<AddressesNotifier>(
      builder: (context, provider, child) {
        if (provider.addressList == null) {
          provider.fetchAddresses();
        }

        return provider.listLoading
            ? AppLoading()
            : provider.addressList == null
                ? provider.listErrorMsg == null
                    ? SizedBox()
                    : SizedBox()
                : HomeComboBoxDropDown(
                    addresses: provider.addressList!,
                    defaultAddress: provider.defaultAddress,
                    addressNotifier: provider,
                  );
      },
    );

    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: consumer,
    );
  }
}
