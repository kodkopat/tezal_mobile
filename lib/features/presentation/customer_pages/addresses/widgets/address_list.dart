import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/addresses_result_model.dart';
import '../../../../data/repositories/customer_address_repository.dart';
import '../../address_detail/address_detail_page.dart';
import 'adderss_list_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    Key key,
    @required this.addresses,
    @required this.customerAddressRepo,
    @required this.onActionsComplete,
  }) : super(key: key);

  final List<Address> addresses;
  final CustomerAddressRepository customerAddressRepo;
  final void Function() onActionsComplete;

  @override
  Widget build(BuildContext context) {
    return addresses.isEmpty
        ? _emptyState
        : ListView.builder(
            itemCount: addresses.length,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemBuilder: (context, index) {
              var address = addresses[index];

              return AddressListItem(
                onTap: () {
                  Routes.sailor.navigate(
                    AddressDetailPage.route,
                    params: {"addressId": address.id},
                  );
                },
                address: address,
              );
            },
          );
  }

  Widget get _emptyState => Txt(
        "لیست‌ آدرس‌های شما خالی است",
        style: AppTxtStyles().body..alignment.center(),
      );
}
