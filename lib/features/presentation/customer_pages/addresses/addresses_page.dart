import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/address_notifier.dart';
import '../address_save/address_save_page.dart';
import 'widgets/address_list.dart';

class AddressesPage extends StatelessWidget {
  static const route = "/customer_addresses";

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
                    : AddressList(addresses: provider.addressList);
      },
    );

    return Scaffold(
      appBar: SimpleAppBar().create(
        context,
        text: "آدرس‌های من",
        showBackBtn: true,
      ),
      body: consumer,
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
