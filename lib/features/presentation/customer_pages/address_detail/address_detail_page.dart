// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/address_notifier.dart';
import 'widgets/address_detail_actions_menu.dart';
import 'widgets/address_detail_menu.dart';

class AddressDetailPage extends StatelessWidget {
  static const route = "/customer_address_detail";

  AddressDetailPage({required this.addressId});

  final String addressId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<AddressNotifier>(
      builder: (context, provider, child) {
        if (provider.addressResultModel == null &&
            provider.detailErrorMsg == null) {
          provider.fetchDetail(addressId: addressId);
        }

        return provider.detailLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.detailErrorMsg != null
                ? Txt(
                    provider.detailErrorMsg!,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddressDetailMenu(
                        address: provider.addressResultModel!.data,
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: 0.5,
                        height: 0,
                      ),
                      AddressDetailActionsMenu(
                        addressId: addressId,
                        addressNotifier: provider,
                      ),
                    ],
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات آدرس",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
