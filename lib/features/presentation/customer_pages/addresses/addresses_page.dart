// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_providers/addresses_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../address_save/address_save_page.dart';
import 'widgets/address_list.dart';

class AddressesPage extends StatelessWidget {
  static const route = "/customer_addresses";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<AddressesNotifier>(
      builder: (context, provider, child) {
        Get.put<AddressesNotifier>(provider);

        if (provider.addressesResultModel == null &&
            provider.listErrorMsg == null) {
          provider.fetchAddresses();
        }

        return provider.listLoading
            ? AppLoading()
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
                    : AddressList(
                        addresses: provider.addressList!,
                        addressNotifier: provider,
                      );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).addressesPage,
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
