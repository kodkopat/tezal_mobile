import 'package:flutter/material.dart';

import '../../../providers/customer_providers/addresses_notifier.dart';
import 'address_selector_list_item.dart';

class AddressSelectorList extends StatelessWidget {
  const AddressSelectorList({required this.addressNotifier});

  final AddressesNotifier addressNotifier;

  @override
  Widget build(BuildContext context) {
    var list = addressNotifier.addressList;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list!.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AddressSelectorListItem(
          address: list[index],
          onTap: () {
            addressNotifier.selectedOrderAddressId = list[index].id;
          },
          addressNotifier: addressNotifier,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black12,
          thickness: 0.5,
          height: 0,
        );
      },
    );
  }
}
