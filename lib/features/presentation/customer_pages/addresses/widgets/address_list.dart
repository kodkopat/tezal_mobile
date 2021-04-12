import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../data/models/addresses_result_model.dart';
import '../../address_detail/address_detail_page.dart';
import 'adderss_list_item.dart';

class AddressList extends StatelessWidget {
  const AddressList({required this.addresses});

  final List<Address> addresses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemBuilder: (context, index) {
        return AddressListItem(
          address: addresses[index],
          onTap: () {
            Routes.sailor.navigate(
              AddressDetailPage.route,
              params: {"addressId": addresses[index].id},
            );
          },
        );
      },
    );
  }
}
