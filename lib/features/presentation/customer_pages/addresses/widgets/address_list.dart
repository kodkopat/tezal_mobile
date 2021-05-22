import 'package:flutter/material.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/customer/address_model.dart';
import '../../../providers/customer_providers/addresses_notifier.dart';
import '../../address_detail/address_detail_page.dart';
import 'adderss_list_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    required this.addresses,
    required this.addressNotifier,
  });

  final List<Address> addresses;
  final AddressesNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return AddressListItem(
          address: addresses[index],
          onTap: () {
            Routes.sailor.navigate(
              AddressDetailPage.route,
              params: {"addressId": addresses[index].id},
            );
          },
          addressNotifier: addressNotifier,
        );
      },
    );
  }
}
